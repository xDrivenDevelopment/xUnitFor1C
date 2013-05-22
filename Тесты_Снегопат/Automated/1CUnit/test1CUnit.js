$engine JScript
$uname test1CUnit
$dname Тесты работы 1CUnit в Конфигураторе
$addin global
$addin stdcommands
$addin stdlib

global.connectGlobals(SelfScript);

//{ init
var testBrowser = requireAddin(stdlib.getSnegopatMainFolder() + "scripts\\1CUnit_my\\TestRunner.js"); // если просто написать stdlib.require(fullLoadString, SelfScript), может возникать исключение

stdlib.require('jsUnitCore.js', SelfScript); // если эту строку вставить до предыдущей requireAddin, будет ошибка при выполнении тестов

var testBrowserAddin = addins.byUniqueName("_1CUnitTestRunner");

var testingFormFrom1cEnterprise = null;
ПерезагрузитьТестируемыйСкриптЗапускающийПредприятие();
//ПодключитьсяК_1С_Предприятию_ИспользуяКеширование();

	//var testBrowserForm = testBrowser._1CTestRunnerForm; //testRunner.object._1CTestRunnerForm;
	//var testBrowserAddin = addins.byUniqueName("_1CUnitTestRunner");
	//testBrowserForm.connect(); // ускорение тестирования - Предприятие запускаем только один раз 

function ПерезагрузитьТестируемыйСкриптЗапускающийПредприятие() 
{
//debugger;
	testBrowserAddin = addins.byUniqueName("_1CUnitTestRunner");
	if(!testBrowserAddin) 
		testBrowser = requireAddin(stdlib.getSnegopatMainFolder() + "scripts\\1CUnit_my\\TestRunner.js"); // если просто написать stdlib.require(fullLoadString, SelfScript), может возникать исключение
	else {
		testBrowser = testBrowserAddin.object;
		
		path = testBrowserAddin.fullPath;
		group = testBrowserAddin.group;
		addins.UnloadAddin(testBrowserAddin);
		
		testBrowserAddin = addins.loadAddin(path, group);
		testBrowser = testBrowserAddin.object;
	}
	
	//testBrowser = requireAddin(stdlib.getSnegopatMainFolder() + "scripts\\1CUnit_my\\TestRunner.js"); // если просто написать stdlib.require(fullLoadString, SelfScript), может возникать исключение
	testingFormFrom1cEnterprise = testBrowser.TestRunnerForm1C;
	testingFormFrom1cEnterprise.connectIfNotConnected(); 
}

// ускорение тестирования - Предприятие запускаем только один раз 
function ПодключитьсяК_1С_Предприятию_ИспользуяКеширование() {
//debugger;
    testingFormFrom1cEnterprise = stdlib.UnitTest1C_1CTestRunnerForm;
	try {
	    testingFormFrom1cEnterprise.connectIfNotConnected(); 
	}
	catch(e) {
		testingFormFrom1cEnterprise = testBrowser.TestRunnerForm1C;
        stdlib.UnitTest1C_1CTestRunnerForm = testingFormFrom1cEnterprise;
	    testingFormFrom1cEnterprise.connectIfNotConnected(); 
	}
	
	////естьКешированноеЗначение_И_ИсходныйСкриптНеПерезагружали = stdlib.UnitTest1C_1CTestRunnerForm && stdlib.UnitTest1C_1CTestRunnerForm._super();
	//естьКешированноеЗначение_И_ИсходныйСкриптНеПерезагружали = stdlib.UnitTest1C_1CTestRunnerForm && stdlib.UnitTest1C_1CTestRunnerForm._super;
	////естьКешированноеЗначение_И_ИсходныйСкриптНеПерезагружали = stdlib.UnitTest1C_1CTestRunnerForm && stdlib.UnitTest1C_1CTestRunnerForm._super;
	//
	//if(естьКешированноеЗначение_И_ИсходныйСкриптНеПерезагружали) {
	//	testingFormFrom1cEnterprise = stdlib.UnitTest1C_1CTestRunnerForm;
	//}
	//else{
	//	//testingFormFrom1cEnterprise = testBrowser._1CTestRunnerForm._instance;
	//	//testingFormFrom1cEnterprise = new TestRunnerForm1Cf;
	//	testingFormFrom1cEnterprise = testBrowser.TestRunnerForm1C;
	//	stdlib.UnitTest1C_1CTestRunnerForm = testingFormFrom1cEnterprise;
	//}
	//testingFormFrom1cEnterprise.connectIfNotConnected(); 
}

SelfScript.self['macros Убрать кеш'] = function () {    
	stdlib.UnitTest1C_1CTestRunnerForm = null;
}

function requireAddin(fullLoadString) {
    var lib = addins.byFullPath(fullLoadString);
    
    if (!lib){
		return stdlib.require(fullLoadString, SelfScript);
	}
	return lib;
}
//} init


//{ test setUp/tearDown    
function setUp() {
}

function tearDown() {
	//testingFormFrom1cEnterprise.close();
	//addins.UnloadAddin(testBrowserAddin);
}
//} test setUp/tearDown

//{ tests

var test1CPath = v8New("File", SelfScript.fullPath).Path + "\\Тесты\\";

SelfScript.self['macrosTest Открытие/закрытие браузера тестов'] = function () {    
		assertNotNull("addin _1CUnitTestRunner не загружен", testBrowser);    
		assertNotNull("форма testingFormFrom1cEnterprise не инициализирована", testingFormFrom1cEnterprise);    
	testingFormFrom1cEnterprise.open();
	testingFormFrom1cEnterprise.close();
}

SelfScript.self['macrosTest Загрузить тесты'] = function () {    
	testingFormFrom1cEnterprise.open();
	testingFormFrom1cEnterprise.LoadAllTests(test1CPath);
	//Предупреждение(1);
}

SelfScript.self['macrosTest Загрузить тесты (нажатие кнопки)'] = function () {    
	testingFormFrom1cEnterprise.open();
	testingFormFrom1cEnterprise.LoadAllTestWithSelectFolderPath();
	//Предупреждение(1);
}

SelfScript.self['macrosTest Запустить все тесты'] = function () {    
	testingFormFrom1cEnterprise.open();
	testingFormFrom1cEnterprise.LoadAllTests(test1CPath);

	testingFormFrom1cEnterprise.RunAllTests();
}

function m_macrosTestAnalyseModule1() {

//debugger;
        
    //Message(cnt.ModuleVars.join(','));
            
    //assertEquals('Неправильно определено количество переменных модуля!', 6, cnt.ModuleVars.length);
    //assertArrayEqualsIgnoringOrder('Неправильно определен список переменных модуля!',
    //    ['мПеременнаяМодуля', 'ЕщеОднаПеременная', 'ЭкспортнаяПеременная', 
    //    'ЭкспортныйМассив', 'ЛокальныйМассив', 'ПростоПеременная'], cnt.ModuleVars);
//
    //assertEquals('Неправильно определено количество методов!', 2, cnt.Methods.length);
    //    
    //assertUndefined(cnt.getMethodByName('НесуществующийМетод'));
    //
    //var method = cnt.getMethodByName('МояФункция');
    //assertNotUndefined("Метод МояФункция не найден", method);    
    //assertArrayEqualsIgnoringOrder(['ПараметрФункции'], method.Params);
    //assertFalse(method.IsProc)
//
    //var proc = cnt.getMethodByName('МояПроцедура');
    //assertNotNull("Метод МояПроцедура не найден", proc);    
    //assertArrayEqualsIgnoringOrder(['Парам1', 'Парам2'], proc.Params);
    //assertTrue(proc.IsProc)
    
}


//} tests

