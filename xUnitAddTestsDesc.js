$engine JScript
$uname xUnitAddTestsDesc
$dname Добавить описания тестовых случае xUnitFor1C
$addin global
$addin stdlib
$addin stdcommands

stdlib.require('TextWindow.js', SelfScript);
stdlib.require('log4js.js', SelfScript);
global.connectGlobals(SelfScript);

var logger = addLogger(SelfScript.uniqueName, Log4js.Level.DEBUG); //var logger = addLogger(SelfScript.uniqueName, Log4js.Level.ERROR);

var	TEST_CASE_DESC_FUNC_NAME = 'ПолучитьСписокТестов'

function addLogger(loggerName, logLevel) {
	var logger = Log4js.getLogger(loggerName);
	var appender = new Log4js.BrowserConsoleAppender();
	appender.setLayout(new Log4js.PatternLayout(Log4js.PatternLayout.TTCC_CONVERSION_PATTERN));
	// следующий код нужен, чтобы при перезапуске скрипта без перезапуска Конфигуратора лог не задвоится
	appenders = [];
	appenders.push(appender);
	logger.onlog = new Log4js.CustomEvent();
	logger.onclear = new Log4js.CustomEvent();

	logger.setAppenders(appenders); // конец блока исключения задвоения лога
	//logger.addAppender(new Log4js.FileAppender("f:\\somefile.log"));
	logger.setLevel(logLevel);
	return logger;
}

SelfScript.self['macrosВставить определения тестовых случаев xUnitFor1C'] = function() {
	var tw = GetTextWindow();
	if (!tw | tw.IsReadOnly()) {
		logger.debug('Не нашли текстовое окно или окно для чтения')
		return true;
	}
		
	var prgText = tw.text()
	var parser = snegopat.parseSources(prgText)
		
	var indexTestCaseDescFunc = parser.idxOfName(TEST_CASE_DESC_FUNC_NAME)
		logger.debug('parser.idxOfName("'+TEST_CASE_DESC_FUNC_NAME+'")=' + indexTestCaseDescFunc)
	if (-1 == indexTestCaseDescFunc) {
		logger.debug('Не нашли функцию описания тестов "'+TEST_CASE_DESC_FUNC_NAME+'"')
		return true;
	}		
	
	var reStream = parser.reStream
		logger.debug(reStream)
	
	var procNames = getTestCases(parser)
		logger.debug('procNames.length ' + procNames.length)
	
	var data = getLinePosForInsertTestCaseDescriptions(parser, indexTestCaseDescFunc);
	var line = data.EndLine;
	if(line != -1){
		var beginLine = data.BeginLine
		var arrayName = data.ArrayName
		deleteExistTestCaseDesc(tw, beginLine, line, procNames, arrayName)
		
		prgText = tw.text()
		parser = snegopat.parseSources(prgText) // т.к. изменили текст, заново парсим
		data = getLinePosForInsertTestCaseDescriptions(parser, indexTestCaseDescFunc);
		line = data.EndLine;
		if(line != -1){
			insertTestCaseDescIntoText(tw, line, procNames, arrayName);
		}
	}
	else
		logger.debug('Не удалось получить позицию для вставки описания тестовых случаев')
		
	return true;
}

function deleteExistTestCaseDesc(tw, beginLine, endLine, procNames, arrayName) {
	var range = tw.Range(beginLine, 1, endLine)
	var text = range.GetText()
		//logger.debug('Текст функции '+TEST_CASE_DESC_FUNC_NAME + '\n'+text)
	
	for(i=0; i < procNames.length; i++) {
		var reTestCaseDesc = new RegExp( '^\\s*'+arrayName+'\\.Добавить\\(\\s*"'+procNames[i]+'"\\s*\\)\\s*;\\s*$', "igm");
			logger.debug('Регулярное выражение шаблона замены '+reTestCaseDesc.source)
		text = text.replace(reTestCaseDesc,"");
	}
		//logger.debug('Новый текст функции '+TEST_CASE_DESC_FUNC_NAME + '\n'+text)
	range.SetText(text)
}

function insertTestCaseDescIntoText(tw, line, procNames, arrayName){
	logger.debug('arrayName <' + arrayName+'>')
	array = new Array(procNames.length);
	for(i=0; i < procNames.length; i++) {
		str = '\t'+arrayName+'.Добавить("'+procNames[i]+'");';
		array[i] = str;
			logger.debug('Вставляю строку - ' + str)
	}
	array[procNames.length] = "";
	tw.InsertLine(line, StringUtils.fromLines(array));
}

function getLinePosForInsertTestCaseDescriptions(parser, indexTestCaseDescFunc){
	var resEndLine = -1;
	var resArrayName = ''
	var resBeginLine = -1
	
	strForStream = addLeftString(indexTestCaseDescFunc, "0", 6-(""+indexTestCaseDescFunc).length)

    var reStream = parser.reStream
	// ищу Функция ПолучитьСписокТекстов(юТестирование) Экспорт ... ВсеТесты = Новый Массив; ... Возврат ВсеТесты; ...
	var reTestCaseDescriptionsFuncBody = new RegExp('FuNm('+strForStream+')LpNm(\\d{6})RpEx.*?(Nm(\\d{6})EqNwNm(\\d{6})).*?ReNm(\\d{6})', "g");
		//var reTestCaseDescriptionsFuncBody = /FuNm(\d{6})LpNm(\d{6})RpEx.*?(Nm(\d{6})EqNwNm(\d{6})).*?ReNm(\d{6})/g
	var reTestCaseDescriptionsFuncName = new RegExp(TEST_CASE_DESC_FUNC_NAME, 'i'); // /ПолучитьСписоктестов/i
	
	resArray = reTestCaseDescriptionsFuncBody.exec(reStream)
	if(resArray && resArray.length >= 6)
    {
   		logger.debug(TEST_CASE_DESC_FUNC_NAME + ' (конец) resArray.index ' + resArray.index + ' resArray.lastIndex ' + resArray.lastIndex )
		var testCaseDescriptionsFuncName = parser.name(resArray[1])
		
		var testCaseArrayName = parser.name(resArray[4]) //ВсеТесты из строки "ВсеТесты = Новый Массив"
		var arrayKeywordName = parser.name(resArray[5]) // Массив
		var returnValueName = parser.name(resArray[6]) // Возврат ВсеТесты
			logger.debug('Наименование массива имен тестовых случаев "' + testCaseArrayName+'"')
		
		var reArrayKeywordName = /массив/i
		if (reArrayKeywordName.test(arrayKeywordName) && testCaseArrayName.toLowerCase() == returnValueName.toLowerCase() 
			&& reTestCaseDescriptionsFuncName.test(testCaseDescriptionsFuncName)) {
			
	        var lex = parser.lexem(parser.posToLexem(resArray.index))
		       	logger.debug('Получили данные по началу функции "'+TEST_CASE_DESC_FUNC_NAME+';" , строка ' + lex.line)
			resBeginLine = lex.line
			
			resArrayName = testCaseArrayName
				logger.debug('Возвращаю наименование массива имен тестовых случаев "' + testCaseArrayName+'"')
				
	        var lex = parser.lexem(parser.posToLexem(resArray.lastIndex))
		       	logger.debug('Получили данные по строке "Возврат '+testCaseArrayName+';" , строка ' + lex.line)
			resEndLine = lex.line
		}
		else {
			logger.error('Должна быть строка "'+TEST_CASE_DESC_FUNC_NAME+'". А получили "' + testCaseDescriptionsFuncName+'"')
			logger.error('Должна быть строка "Массив". А получили "' + arrayKeywordName+'"')
			logger.error('Должна быть строка "'+testCaseArrayName+'". А получили "' + returnValueName+'"')
		}
    }
	else {
		logger.error('Не нашли функцию '+TEST_CASE_DESC_FUNC_NAME+' с необходимой структурой');
		if(resArray)
			logger.error('Количество элементов в массиве разбора лексем (resArray.length) должно быть больше или равно 6, а получили "' + resArray.length+'"')
	}
	return { BeginLine: resBeginLine, EndLine: resEndLine, ArrayName: resArrayName };
}

function addLeftString(src, str, count) {
	res = src;
	for(i=0; i < count; i++)
		res = str + res;
	return res;
}

function getTestCases(parser){
	var res = new Array();
    var reStream = parser.reStream
    var rePublicProcedureWithoutParams = /(Pc)Nm\d{6}LpRpEx/g
    var reTestCaseName = /^тест/i

    while(rePublicProcedureWithoutParams.exec(reStream))
    {
        var lex = parser.lexem(parser.posToLexem(RegExp.index + 2))
       	logger.debug('проверяю процедуру ' + lex.text + ", строка " + lex.line)
        if (reTestCaseName.exec(lex.text)){
        	logger.debug('\tнашли тестовый случай ' + lex.text + ", строка " + lex.line)
        	res.push( lex.text )
        }
    }
    return res;
}
