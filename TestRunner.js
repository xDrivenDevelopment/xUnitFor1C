$engine JScript
$uname _1CUnitTestRunner
$dname 1CUnit: Юнит-тестирование для 1С:Предприятия 8
$addin stdcommands
$addin stdlib
$addin global

global.connectGlobals(SelfScript);

stdlib.require("ScriptForm.js", SelfScript);

////////////////////////////////////////////////////////////////////////////////////////
////{ Cкрипт "1CUnit: Юнит-тестирование для 1С:Предприятия 8" (TestRunner.js) для проекта "Снегопат"
////
//// Описание: Запуск юнит-тестов системы юнит-тестирования 1CUnit для 1С:Предприятия 8
//// из конфигуратора 1С:Предприятия при помоги Снегопата.
////
//// Автор: Александр Кунташов <kuntashov@gmail.com>, http://compaud.ru/blog
////}

SelfScript.self['macrosОткрыть'] = function () {    
    _1CTestRunnerForm.Open();
};

SelfScript.self['macrosЗакрыть'] = function () {    
    _1CTestRunnerForm.Close();
};

SelfScript.self['macrosЗагрузить все тесты'] = function () {    
    _1CTestRunnerForm.LoadAllTests();
};

SelfScript.self['macrosЗагрузить отдельный тест'] = function () {    
    _1CTestRunnerForm.LoadTest();
};

SelfScript.self['macrosВыполнить все тесты'] = function () {    
    _1CTestRunnerForm.RunAllTests();
};

SelfScript.self['macrosВыполнить выбранный тест'] = function () {    
    _1CTestRunnerForm.RunTest();
};

////////////////////////////////////////////////////////////////////////////////////////
////{ Класс _1CTestRunnerForm
////

_1CTestRunnerForm = new (ScriptForm.extend({

	settingsRootPath : SelfScript.uniqueName,

	construct: function () {	
        this._super(SelfScript.fullPath.replace(/js$/, 'ssf'));                
        this.form.КлючСохраненияПоложенияОкна = SelfScript.uniqueName;
        this.v8 = null;
        this.testRunner = null;
        this.testTree = this.form.TestTree;
        this.form.Controls.TestTree.Columns.Name.ShowHierarchy = true;
	},

	Open: function () {
		this.show();
	},
	
	Close: function () {
		this.close();
	},
	
	LoadAllTests: function () {
	},
	
	LoadTest: function () {
		Message('LoadTest');	
	},
	
	RunAllTests: function () {
				    
		this.Open();
		
        this.treeCache = v8New('Map');	
        this.testTree.Rows.Clear();

		var runner = this.connect();

		this.testRunner.LoadAllTests(stdlib.getSnegopatMainFolder() + "user\\1CUnit\\Тесты");        
	    
	    runner.RunAllTests();
	    
	    this.disconnect();
	},
	
	RunTest: function () {
	
	},

	/* Обработчики событий от TestRunner'а. */
	
	TestLoaded: function (objTest) {
		var parentRow = this.getTestRow(objTest._guid);
		if (!parentRow) {
			parentRow = this.testTree;
		}
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
	
	connect: function () {
	    
		if (!this.v8) {
		    this.v8 = new ActiveXObject("V82.Application");
		    
		    this.v8.Connect(this.getConnectString());
		    this.v8.Visible = false;
		    
			this.testRunner = this.v8.ExternalDataProcessors.Create(this.getTestRunnerFilepath());
			
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
	    
	    return this.testRunner;
	},

	disconnect: function () {
		this.testRunner.SetHandlerObject(null);
		this.testRunner = null;
		this.v8 = null;
	},
		
	getTestRunnerFilepath: function () {
		return stdlib.getSnegopatMainFolder() + "user\\1CUnit\\UnitTestRunner.epf";
	},
	
	getConnectString: function () {
	    //Артур: Нужно брать из профайmла CmdLine\UserName и CmdLine\UserPassword
		var connStr = InfoBaseConnectionString();
		connStr += 'Usr="' + profileRoot.getValue("CmdLine/UserName") + '";';
		connStr += 'Pwd="' + profileRoot.getValue("CmdLine/UserPassword") + '";';
		return connStr;
	},
	
	/* Обработчики событий формы. */
	
	CmdBar_LoadAllTests: function() {
		this.LoadAllTests();
	},
	
	CmdBar_RunTest: function() {
		this.RunAllTests();
	}

}));

////
////} Класс _1CTestRunnerForm
////////////////////////////////////////////////////////////////////////////////////////////