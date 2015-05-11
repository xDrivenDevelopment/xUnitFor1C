#!/bin/sh
# This scripts is used to install dependencies

echo "run Xvfb vnc server"
/usr/bin/Xvfb :1 -screen 0 1024x768x16 &
sleep 1
#vncserver -kill :1
mkdir ~/.vnc
#x11vnc -storepasswd 123456 ~/.vnc/passwd
export DISPLAY=:1
/usr/bin/lxsession &
x11vnc -display :1 -xkb &
#vncserver
#sleep 3

#/usr/bin/lxsession &

