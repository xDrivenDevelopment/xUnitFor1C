#!/bin/sh
# This scripts is used to install dependencies

echo "run vnc server"
vncserver -kill :1
mkdir ~/.vnc
x11vnc -storepasswd 123456 ~/.vnc/passwd
vncserver
sleep 3
export DISPLAY=:1
/usr/bin/lxsession &

