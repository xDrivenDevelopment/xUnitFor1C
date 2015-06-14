#!/usr/bin/env python3
# encoding: utf-8

import socketserver
import http.server
from time import sleep
import threading
import cgi
import argparse
from urllib.parse import urlparse
import base64
import json
import re
import sys
import os
import signal
import logging
from bottle import route, run, request

__version__='0.0.2'

logging.basicConfig(filename='myapp.log', level=logging.INFO)  # DEBUG => print ALL msgs
log = logging.getLogger('proxy')




command = None
response = None
step = None
args, debugargs = None, False
endTest = None

@route('/hello')
def hello():
    global command
    global response
    if command is not None:
        result = command
        command = None
        return result
    if endTest == True:
        return "endalltest"
    
    return ""

@route('/result', method='POST')
def result_do():
    global response
    reg = request.body
    result = reg.read().decode("utf-8")
    if result.startswith(u'\ufeff'):
        result = result[1:]
    log.info("result {}".format(result))
    #print("result {}".format(result))
    response = result
    return result

@route('/argstoarray', method='POST')
def argstoarray():
    reg = request.body
    result = reg.read().decode("utf-8")
    if result.startswith(u'\ufeff'):
        result = result[1:]
    
    stepdef = json.loads(result)
    print("argstoarray {}".format(stepdef))
    if type(stepdef) == list and len(stepdef) > 0:
        if type(stepdef[0]) == str:
            result = "\n".join(stepdef)
        elif type(stepdef[0]) == list and len(stepdef[0]) > 0:
            for k in stepdef[0]:
                print(k)
            
    print(result)
    return result
    

@route('/stepdefition')
def stepdefition():
    global step
    result = step
    step = None
    log.info("step {}".format(result))
    return result

@route('/stepargs')
def stepargs():
    global args
    result = args
    args = None
    log.debug("stepargs {}".format(result))
    return result

@route('/exit')
def exitbottle():
    os.kill(os.getpid(), signal.SIGTERM)  

@route('/regexp', method='POST')
def regexp():
    reg = request.body
    print(reg.read().decode("utf-8"))
    return ""
    
    
    

class MyTCPHandler(socketserver.BaseRequestHandler):
    """
    The RequestHandler class for our server.

    It is instantiated once per connection to the server, and must
    override the handle() method to implement communication to the
    client.
    """
    
    def handle(self):
        global response, endTest, command, args, debugargs
        count = 0
        while True:
            self.data = self.request.recv(8024).strip()
            tempdata = self.data.decode("utf-8")
            print("recive:{}".format(tempdata))
            if not self.data:
                count = count+1
                if count > 20:
                    endTest = True
                    break
                sleep(0.5)
                continue
            if len(tempdata.strip()) <1:continue
            log.debug(tempdata)
            command = self.parsestep(tempdata)
            if not args is None and debugargs:
                print("response debug")
                response = args
                
            count = 0
            #print("{} wrote: {}".format(self.client_address[0], command))
            #response = '["success"]\n'
            while (response is None):
                #print("response {}".format(response))
                sleep(1)
            
            #print("send:{}".format(response))
            tempdata = response + "\n"
            self.request.sendall(tempdata.encode("utf-8"))
            response = None
            sleep(1)
    
    def parsestep(self, step_definiton):
        global step
        global args
        step = None
        args = None
        log.info("step_definiton {}".format(step_definiton))
        stepdef = json.loads(step_definiton)
        if stepdef[0]!="step_matches":
            return step_definiton
        name_to_match = stepdef[1]["name_to_match"]
        args = []
        strList, dateList, intList = [], [], []
        pstring = re.compile("\'[^\']+\'")
        pdate = re.compile("\d{2}\.\d{2}\.\d{2,4}")
        pint = re.compile("[-+]?[0-9]*\.?[0-9]+")

        def applyre(matchstring, re, name, founds):
            allfound = re.findall(matchstring)
            for value in allfound:
                matchstring = matchstring.replace(value, name)
                founds.append(value)
            return matchstring

        name_to_match = applyre(name_to_match, pstring, '<ПараметрСтрока>', strList)
        name_to_match = applyre(name_to_match, pdate, '<ПараметрДата>', dateList)
        name_to_match = applyre(name_to_match, pint, '<ПараметрЧисло>', intList)
        name_to_match = name_to_match.replace(".", "").replace(",", "").replace(":", "")
        
        stepDefinition = ""
        words = name_to_match.split(" ")
        for word in words:
            if word == '<ПараметрСтрока>':
                args.append({'val':strList.pop(0)})
            elif word == '<ПараметрДата>':
                args.append({'val':dateList.pop(0)})
            elif word == '<ПараметрЧисло>':
                args.append({'val':intList.pop(0)})
            else:
                stripword = word.strip()
                stepDefinition = stepDefinition+stripword[:1].upper()+stripword[1:]
        step = stepDefinition
            
        args = json.dumps(["success", [{"id":stepDefinition, "args":args}]], ensure_ascii=False)
        
        return step_definiton
        
            
        

if __name__ == "__main__":
    
    parser = argparse.ArgumentParser(description='Прокси между cucumber wire протокол и http сервис для 1с')
    parser.add_argument('--version', action='version', version='%(prog)s {}'.format(__version__))
    parser.add_argument('-v', '--verbose', dest='verbose_count', action='count', default=0,
                        help='Increases log verbosity for each occurence.')
    parser.add_argument('--g', action='store_true', default=False,
                        help='Генерация кода теста для 1с')
    
    argspars = parser.parse_args()

    log.setLevel(10)#max(3 - args.verbose_count, 0) * 10)
    
    
    HOST, PORTWIRE, PORTHTTP = "localhost", 54321, 54322

    # Create the server, binding to localhost on port 9999
    server = socketserver.TCPServer((HOST, PORTWIRE), MyTCPHandler)
    if argspars.g is True:
        debugargs = True
    # Activate the server; this will keep running until you
    # interrupt the program with Ctrl-C
    print('first server')
    server_thread = threading.Thread(target=server.serve_forever)
    
    server_thread.daemon = True
    server_thread.start()
    print('two server')
    try:
        run(host=HOST, port=PORTHTTP, debug=False, quiet=True)
    except SystemExit:
        print("exiting")
    sys.exit(0)
    