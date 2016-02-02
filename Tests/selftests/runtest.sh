#!/bin/sh

export WORKSPACE=`pwd`
echo $WORKSPACE
if test -d $WORKSPACE/build/ib; then rm -rf $WORKSPACE/build/ib; fi

mkdir $WORKSPACE/build -p
mkdir $WORKSPACE/build/ib -p

if test -d $WORKSPACE/test-reports; then rm -rf $WORKSPACE/test-reports; fi
mkdir $WORKSPACE/test-reports/ordinary -p

if test -f /opt/1C/v8.3/x86_64/1cestart; then 
	oneC_root=/opt/1C/v8.3/x86_64;
else 
	oneC_root=/opt/1C/v8.3/i386;
fi

if [ "$CONN_STRING" ]; then
	CONN='$CONN_STRING'
else
	CONN="/F$WORKSPACE/build/ib/"
	echo "create database $oneC_root"
	$oneC_root/1cv8 CREATEINFOBASE "File='$WORKSPACE/build/ib/'" /Lru
fi

#/opt/1C/v8.3/x86_64/1cv8 CREATEINFOBASE "Srvr=localhost;Ref=test;DBMS=PostgreSQL;DBSrvr=localhost;DB=test;DBUID=postgres;DBPwd=vagrant;Locale=ru;CrSQLDB=Y;LicDstr=Y" /AddInList"test"

echo "resotore base"
$oneC_root/1cv8 DESIGNER $CONN /Lru /RestoreIB $WORKSPACE/Tests/TestBase.dt
echo "load cf"
$oneC_root/1cv8 DESIGNER $CONN /Lru /LoadCfg$WORKSPACE/Tests/TestConfig.cf /UpdateDBCfg

echo "run thick client ordinary mode"
echo "$oneC_root/1cv8" ENTERPRISE /Lru $CONN /Nadmin /C"xddRun;$WORKSPACE/Tests/;xddReportFormat;xml;xddExitCodePath;$WORKSPACE/out.txt;xddReportPath;$WORKSPACE/test-reports/thick.xml;" /Execute"$WORKSPACE/xddTestRunner.epf" /RunModeOrdinary /outrunTest.txt
"$oneC_root/1cv8" ENTERPRISE /Lru /VLru $CONN /Nadmin /C"xddRun;$WORKSPACE/Tests/;xddReportFormat;xml;xddExitCodePath;$WORKSPACE/out.txt;xddReportPath;$WORKSPACE/test-reports/thick.xml;" /Execute"$WORKSPACE/xddTestRunner.epf" /RunModeOrdinary /outrunTest.txt
"$oneC_root/1cv8c" ENTERPRISE /Lru /VLru $CONN /Nadmin /C"xddRun;$WORKSPACE/Tests/;xddReportFormat;xml;xddExitCodePath;$WORKSPACE/out.txt;xddReportPath;$WORKSPACE/test-reports/thin_Managedapp.xml;" /Execute"$WORKSPACE/xddTestRunner.epf" /outrunTest.txt  /TESTMANAGER
"$oneC_root/1cv8" ENTERPRISE /Lru /VLru $CONN /Nadmin /C"xddRun;$WORKSPACE/Tests/;xddReportFormat;xml;xddExitCodePath;$WORKSPACE/out.txt;xddReportPath;$WORKSPACE/test-reports/thick_all.xml;" /Execute"$WORKSPACE\xddTestRunner.epf" /outrunTest.txt /RunModeManagedApplication /TESTMANAGER
