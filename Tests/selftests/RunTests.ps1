#"C:\Program Files (x86)\1cv82\8.2.18.96\bin\1cv8c.exe" /DisableStartupMessages /Execute E:\ТестыИМ\xddTestRunner.epf /S "as-msk-a6122\im_test" /Out "E:\ТестыИМ\Тесты\log.txt"  /C "Тесты_Команда_Тестировать;E:\ТестыИМ\Тесты;ЗавершитьРаботуПослеТестирования" /LogUI
@'
if ($args.count -gt 0) { $basePath = args[0] }
else { $basePath = "C:\Users\aayuhanov\Documents\1c\1cv77\Конфигурации\АвтообновлениеКонфигурации" }

$bin1c = "${env:ProgramFiles(x86)}\1cv77\BIN.SQL\1cv7s.exe"
If (!(Test-Path $bin1c)) {
	$bin1c = "$env:ProgramFiles\1cv77\BIN.SQL\1cv7s.exe"
}
$bin1c
$basePath

    #start "" /wait %bin1c% config /m /D"$basePath\База" /loadmd"$basePath\База_1Cv7.MD"
Start-Process $bin1c "config /m /D""$basePath\База"" /loadmd""$basePath\База_1Cv7.MD"" " -Wait
Get-Content d:\ЗагрузкаОбъединениеМД.log

"."

Start-Process $bin1c  "config /m /D""$basePath\База"" /loadmd""$basePath\УдалилСпр_ИзменилТипРеквизита_1Cv7.MD"" " -Wait
Get-Content d:\ЗагрузкаОбъединениеМД.log
'@

if ($args.count -gt 0) { $basePath = args[0] }
else { $basePath = "W:\1CUnit\ТестоваяБаза" }

if ($args.count -gt 1) { $TestRunnerPath = args[1] }
else { $TestRunnerPath = "C:\Projects\GitHub\xUnitFor1C\xddTestRunner.epf" }

if ($args.count -gt 2) { $TestsPath = args[2] }
else { $TestsPath = "C:\Projects\GitHub\xUnitFor1C\Tests\CommonApp\ТестПримерТеста.epf" }
#else { $TestsPath = "C:\Projects\GitHub\xUnitFor1C\Tests\selftests" }
#else { $TestsPath = "Метаданные.Подсистемы.Тестовая" }

$bin1c = "${env:ProgramFiles(x86)}\1cv82\8.2.19.68\bin\1cv8.exe"
#$bin1c = "${env:ProgramFiles(x86)}\1cv82\8.2.19.68\bin\1cv8c.exe"
@'
If (!(Test-Path $bin1c)) {
	$bin1c = "$env:ProgramFiles\1cv77\BIN.SQL\1cv7s.exe"
}
'@
$logPath = "D:\log.txt"

$bin1c
$basePath
$TestRunnerPath
$TestsPath

    #start "" /wait %bin1c% config /m /D"$basePath\База" /loadmd"$basePath\База_1Cv7.MD"
#"C:\Program Files (x86)\1cv82\8.2.18.96\bin\1cv8c.exe" /DisableStartupMessages /Execute E:\ТестыИМ\xddTestRunner.epf /S "as-msk-a6122\im_test" /Out "E:\ТестыИМ\Тесты\log.txt"  /C "Тесты_Команда_Тестировать;E:\ТестыИМ\Тесты;ЗавершитьРаботуПослеТестирования" /LogUI
Start-Process $bin1c " /F ""$basePath"" /NАдминистратор /DisableStartupMessages /Execute $TestRunnerPath /Out $logPath  /C ""xddRun;$TestsPath;xddShutdown1"" /LogUI " -Wait
Get-Content $logPath

"."
