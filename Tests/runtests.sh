#!/usr/bin/sh

WORKSPACE=`pwd`

if test -d $WORKSPACE/build; then rm -rf $WORKSPACE/build;fi
mkdir $WORKSPACE/build -p

if test -d $WORKSPACE/test-reports; then rm -rf $WORKSPACE/test-reports;fi
mkdir $WORKSPACE/test-reports/ordinary -p

if test -d /opt/1C/v8.3/x86_64; then 
	oneC_root=/opt/1C/v8.3/x86_64
else 
	oneC_root=/opt/1C/v8.3/i386
fi


echo "create database $oneC_root"
$oneC_root/1cv8 CREATEINFOBASE  File=$WORKSPACE/build/ib/ /Lru
echo "resotore base"
$oneC_root/1cv8 DESIGNER /F$WORKSPACE/build/ib/ /Lru /RestoreIB $WORKSPACE/Tests/TestBase.dt
echo "load cf"
$oneC_root/1cv8 DESIGNER /F$WORKSPACE/build/ib/ /Nadmin /Lru /LoadCfg$WORKSPACE/Tests/TestConfig.cf /UpdateDBCfg

echo "run thick client ordinary mode"
echo "$oneC_root/1cv8" ENTERPRISE /Lru /F"$WORKSPACE/build/ib/" /Nadmin /C"xddRun;$WORKSPACE/Tests/;xddReportFormat;xml;xddExitCodePath;$WORKSPACE/out.txt;xddReportPath;$WORKSPACE/test-reports/thick.xml;" /Execute"$WORKSPACE/xddTestRunner.epf" /RunModeOrdinary /outrunTest.txt
"$oneC_root/1cv8" ENTERPRISE /Lru /F"$WORKSPACE/build/ib/" /Nadmin /C"xddRun;$WORKSPACE/Tests/;xddReportFormat;xml;xddExitCodePath;$WORKSPACE/out.txt;xddReportPath;$WORKSPACE/test-reports/thick.xml;" /Execute"$WORKSPACE/xddTestRunner.epf" /RunModeOrdinary /outrunTest.txt
"$oneC_root/1cv8c" ENTERPRISE /Lru /F"$WORKSPACE/build/ib/" /Nadmin /C"xddRun;$WORKSPACE/Tests/;xddReportFormat;xml;xddExitCodePath;$WORKSPACE/out.txt;xddReportPath;$WORKSPACE/test-reports/thin_Managedapp.xml;" /Execute"$WORKSPACE/src/xddTestRunner.epf" /outrunTest.txt  /TESTMANAGER
"$oneC_root/1cv8" ENTERPRISE /Lru /F"$WORKSPACE/build/ib/" /Nadmin /C"xddRun;$WORKSPACE/src/Tests/;xddReportFormat;xml;xddExitCodePath;$WORKSPACE/out.txt;xddReportPath;$WORKSPACE/test-reports/thick_all.xml;" /Execute"$WORKSPACE\src\xddTestRunner.epf" /outrunTest.txt /RunModeManagedApplication /TESTMANAGER
