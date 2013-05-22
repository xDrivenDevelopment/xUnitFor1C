$engine JScript
$uname _1CUnitTestRunner
$dname 1CUnit: Юнит-тестирование для 1С:Предприятия 8
$addin stdcommands
$addin stdlib
$addin global

global.connectGlobals(SelfScript);
events.connect(Designer, "onUnLoadAddin", SelfScript.self)

stdlib.require("ScriptForm.js", SelfScript);


////////////////////////////////////////////////////////////////////////////////////////
////{ Cкрипт "1CUnit: Юнит-тестирование для 1С:Предприятия 8" (TestRunner.js) для проекта "Снегопат"
////
//// Описание: Запуск юнит-тестов системы юнит-тестирования 1CUnit для 1С:Предприятия 8
//// из конфигуратора 1С:Предприятия при помоги Снегопата.
////
//// Автор: Александр Кунташов <kuntashov@gmail.com>, http://compaud.ru/blog
////}

function onUnLoadAddin(addin)
{
	//if(this.isConnect())
	//MessageBox("TestRunnerForm1C onUnLoadAddin");
	//delete this.v8;
};

SelfScript.self['macrosОткрыть'] = function () {    
    var $this = Get1CTestRunnerForm();
    $this.open();
};

SelfScript.self['macrosЗакрыть'] = function () {    
    var $this = Get1CTestRunnerForm();
    $this.close();
};

SelfScript.self['macrosЗагрузить все тесты'] = function () {    
    var $this = Get1CTestRunnerForm();
    $this.LoadAllTests();
};

SelfScript.self['macrosЗагрузить отдельный тест'] = function () {    
    var $this = Get1CTestRunnerForm();
    $this.LoadTest();
};

SelfScript.self['macrosВыполнить все тесты'] = function () {    
    var $this = Get1CTestRunnerForm();
    $this.RunAllTests();
};

SelfScript.self['macrosВыполнить выбранный тест'] = function () {    
    var $this = Get1CTestRunnerForm();
    $this.RunTest();
};

SelfScript.self['macrosПерезагрузить 1С:Предприятие'] = function () {    
    var $this = Get1CTestRunnerForm();
	$this.disconnect();
	$this.connectIfNotConnected();
	
	//$this.close();
	$this.open();
};

////////////////////////////////////////////////////////////////////////////////////////
////{ Класс TestRunnerForm1C
////

//TODO если пишем TestRunnerForm1C = new (ScriptForm.extend({
// т.е. с использованием new, то при загрузке скрипта будут ошибки на описанных обработчиках событий типа btLoadAllTests_Click

//TestRunnerForm1C =  (ScriptForm.extend({ // так работают обработчики, но не удается подключиться из другого скрипта к экземпляру
TestRunnerForm1C = new (ScriptForm.extend({

	settingsRootPath : SelfScript.uniqueName,
	
	formFolderPath : stdlib.getSnegopatMainFolder() + "scripts\\1CUnit_my\\",
		//stdlib.getSnegopatMainFolder() + "user\\1CUnit\\
		
	testsPath : "",
	
	construct: function () {	
		
        this._super(SelfScript.fullPath.replace(/js$/, 'ssf'));                
        this.form.КлючСохраненияПоложенияОкна = SelfScript.uniqueName;
        this.v8 = null;
        this.testRunner = null;
        this.testTree = this.form.TestTree;
        this.form.Controls.TestTree.Columns.Name.ShowHierarchy = true;
		
		//TestRunnerForm1C._instance = this;
		//Message("TestRunnerForm1C construct")
		
		//events.connect(Designer, "onUnLoadAddin", this, 'onUnLoadAddin');
	},
	
	//onUnLoadAddin : function(addin) {
	//	//if(this.isConnect())
	//	Message("TestRunnerForm1C onUnLoadAddin");
	//	delete this.v8;
	//},
	
	//destruct: function() {
	//	//this.unloadAllEpf();
	//	//if(this.isConnect())
	//	delete this.v8;
	//},

	// TODO БАГ СНЕГОПАТА - если определить метод Open (именно учитывая регистр), то будет баг с обработчиками событий кнопок, например, ЗагрузитьТесты_Нажатие
	// например, в 1.4.7.2 баг есть
	open: function () {
		this.show();
	},
	
	//// TODO БАГ СНЕГОПАТА - если определить метод Close (именно учитывая регистр), то будет баг с обработчиками событий кнопок, например, ЗагрузитьТесты_Нажатие
	//// например, в 1.4.7.2 баг есть
	//close: function () {
	//	this._super().close();
	//},
	
	LoadAllTests: function (path) {
		this.testConnect();
		
		testsPath = path;
		
		this.open();
		
        this.treeCache = v8New('Map');	
        this.testTree.Rows.Clear();

		this.testRunner.LoadAllTests(path);        
	},
	
	LoadTest: function () {
		Message('LoadTest не реализован');	
	},
	
	RunAllTests: function () {
				    
		this.testConnect();
			//this.open();
			//
			//this.treeCache = v8New('Map');	
			//this.testTree.Rows.Clear();

			//this.testRunner.LoadAllTests(this.formFolderPath + "Тесты");        
				////this.testRunner.LoadAllTests(stdlib.getSnegopatMainFolder() + "user\\1CUnit\\Тесты");        
	    
	    this.testRunner.RunAllTests();
	    
	    //this.disconnect(); // TODO включить для реальной работы
	},
	
	RunTest: function () {
		Message('RunTest не реализован');	
	},
	
	LoadTest: function () {
		Message('LoadTest не реализован');	
	},
	
	ReloadTests: function () {
		Message('ReloadTests не реализован');	
	},
	
	/* Обработчики событий от TestRunner'а. */
	
	TestLoaded: function (objTest) {
//debugger;		
		var parentRow = null;
		if(objTest.Родитель)
			parentRow = this.getTestRow(objTest.Родитель._guid); //var parentRow = this.getTestRow(objTest._guid);
			
		if (!parentRow) 
			parentRow = this.testTree;
			
		this.addTreeRow(parentRow, objTest.Имя, objTest.ПолныйПуть, objTest._guid);
	},
	
	TestPassed: function (objTest) {
	},				
	
	TestBroken: function (objTest) {
	},
	
	TestNotImplemented: function (objTest) {
	},	

	getTestRow: function (guid) {
		return this.treeCache.Get(guid);
	},

	addTreeRow: function (parentRow, name, path, guid) {
		var row = parentRow.Rows.Add();
		row.Name = name;
		row.Path = path;
		row._guid = guid;
		this.treeCache.Insert(guid, row);
	},

	/* Вспомогательные процедуры и функции. */
	
	isConnect: function () {
		return this.v8 != null;
	},
	
	testConnect: function () {
		if(!this.isConnect())
			throw "Нет соединения с 1С:Предприятием";
	},
	
	connectIfNotConnected: function () {
	    
		if (!this.isConnect()) { 
		    this.v8 = new ActiveXObject("V82.Application");
		    
		    this.v8.connect(this.getConnectString());
		    this.v8.Visible = true;
		    //this.v8.Visible = false;
		    
			this.testRunner = this.v8.ExternalDataProcessors.Create(this.getTestRunnerFilepath());
			this.testRunner.OpenBrowserForm();
			
			// Установим перехватчик сообщений.
			$this = this;
			this.testRunner.SetHandlerObject({ 
				Message				: function (msg) { Message(msg); },			
				TestLoaded			: function (obj) { $this.TestLoaded(obj); },				
				TestPassed			: function (obj) { $this.TestPassed(obj); },				
				TestBroken			: function (obj) { $this.TestBroken(obj); },
				TestNotImplemented	: function (obj) { $this.TestNotImplemented(obj) }				
			}); 
		}
		
		try{
	    	this.v8.Visible = true;
		}
		catch(e){ // если приложение уже закрылось. TODO не знаю, как без исключения это проверить.
		}
		
	    return this.testRunner;
	},

	disconnect: function () {
		if(this.isConnect()) 
		{
			try{
				this.testRunner.SetHandlerObject(null);
			}
			catch(e){ // если приложение уже закрылось. TODO не знаю, как без исключения это проверить.
			}
		}
		this.testRunner = null;
		this.v8 = null;
	},
	
	LoadAllTestWithSelectFolderPath: function() {
		path = this.SelectFolderPath()
		if(path != null)
			this.LoadAllTests(path);
	},

	SelectFolderPath : function () {
	
		ДиалогВыбораКаталога = v8New("ДиалогВыбораФайла", РежимДиалогаВыбораФайла.ВыборКаталога);
		ДиалогВыбораКаталога.Каталог = testsPath;

        if(ДиалогВыбораКаталога.Выбрать() != false) {
			
			testsPath = ДиалогВыбораКаталога.Каталог;
			return testsPath;
		}
		
				//ДиалогОткрытияФайла=v8New("ДиалогВыбораФайла", РежимДиалогаВыбораФайла.Открытие)
				//ДиалогОткрытияФайла.ПолноеИмяФайла = ""+Control.val.Значение;
				//ДиалогОткрытияФайла.Заголовок = "Выберите внешнюю обработку"
				//if(ДиалогОткрытияФайла.Выбрать()==false) {
				//	
				//} else {
				//	Control.val.Значение = ДиалогОткрытияФайла.ПолноеИмяФайла;
				//}
		
		return null;
		
	},
		
	getTestRunnerFilepath: function () {
		return this.formFolderPath + "UnitTestRunner.epf"
			//return stdlib.getSnegopatMainFolder() + "user\\1CUnit\\UnitTestRunner.epf";
	},
	
	getConnectString: function () {
	    //Артур: Нужно брать из профайmла CmdLine\UserName и CmdLine\UserPassword
		var connStr = InfoBaseConnectionString();
		connStr += 'Usr="' + profileRoot.getValue("CmdLine/UserName") + '";';
		connStr += 'Pwd="' + profileRoot.getValue("CmdLine/UserPassword") + '";';
		return connStr;
	},
	
	/* Обработчики событий формы. */
	
	// TODO смотрим выше коммент для TestRunnerForm1C = new (ScriptForm.extend({
	
	Form_OnOpen: function(p1) {
		//Message("test Form_OnOpen 2");
	},
	
	ЗагрузитьНаборыТестов_Click: function(Button) {
		//Message("ЗагрузитьВсеТесты_Нажатие");
		this.LoadAllTestWithSelectFolderPath();
	},
	
	ЗагрузитьОтдельныйТестовыйНабор_Нажатие: function(button) {
		Message("ЗагрузитьТесты_Нажатие");
		this.LoadTest();
	},
	
	КнопкаВыполнитьВсеТестыНажатие: function(button) {
		//Message("КнопкаВыполнитьВсеТестыНажатие");
		this.RunAllTests();
	},
	
	КнопкаПерезагрузитьНажатие: function(button) {
		Message("КнопкаПерезагрузитьНажатие");
		this.ReloadTests();
	},
	
	dummy: function() {
		throw(e);
	}
	
}));

//TestRunnerForm1C = new TestRunnerForm1C; // нужно для правильной работы без new (ScriptForm.extend({

function Get1CTestRunnerForm() {
	return TestRunnerForm1C; // так правильнее
	
	//if (!TestRunnerForm1C._instance)
	//	new TestRunnerForm1C();

	//return TestRunnerForm1C._instance;
}

////
////} Класс TestRunnerForm1C
////////////////////////////////////////////////////////////////////////////////////////////