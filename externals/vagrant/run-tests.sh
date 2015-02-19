#!/bin/sh
# This scripts is used to setup temp directory in memory
# for running Mercurial tests in vritual machine managed
# by Vagrant (see Vagrantfile for details).

cd /vagrant
export export DISPLAY=:1
echo "mount in memory"
mkdir /tmp/ram
sudo mount -t tmpfs -o size=200M tmpfs /tmp/ram
export TMPDIR=/tmp/ram
sh ./externals/vagrant/runvnc.sh
/opt/noVNC-0.5.1/utils/launch.sh --vnc localhost:5901 &
ngrok -log=stdout 6080 &

mkdir -p ~/.1cv8/1C/1cv8
cp ./externals/vagrant/1cv8cmn.pfl ~/.1cv8/1C/1cv8/
echo "run tests"
sh ./Tests/selftests/runtest.sh

