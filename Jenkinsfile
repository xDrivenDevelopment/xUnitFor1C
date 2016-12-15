#!groovy
node("slave") {
    stage "checkout"
    //git url: 'https://github.com/silverbulleters/vanessa-behavior-new.git'
    
    checkout scm
    if (env.DISPLAY) {
        println env.DISPLAY;
    } else {
        env.DISPLAY=":1"
    }
    //env.RUNNER_ENV="production";

    if (isUnix()) {sh 'git config --system core.longpaths'} else {bat "git config --system core.longpaths"}

    if (isUnix()) {sh 'git submodule update --init'} else {bat "git submodule update --init"}    

    stage "checkout vanessa-runner"
    checkout([$class: 'GitSCM', branches: [[name: '*/develop']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'vanessa-runner']], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/silverbulleters/vanessa-runner.git']]])

    def vanessa_runner = "./vanessa-runner/tools";

    stage "init base"

    echo "${env.WORKSPACE}"

    def srcpath = "./Tests/cf/83";
    if (env.SRCPATH){
        srcpath = env.SRCPATH;
    }
    def v8version = "";
    if (env.V8VERSION) {
        v8version = "--v8version ${env.V8VERSION}"
    }
    def command = "oscript ${vanessa_runner}/init.os init-dev ${v8version} --src "+srcpath
    timestamps {
        if (isUnix()) {sh "${command}"} else {bat "chcp 1251\n${command}"}       
    }
    
    stage "build"
    
    def connstring = """--ibname /F"./build/ib" """;
    def binary_data = "./build/out";
	
    echo "build catalogs"
    command = """oscript ${vanessa_runner}/runner.os compileepf ${v8version} ${connstring} ./ ${binary_data}/ """
    if (isUnix()) {sh "${command}"} else {bat "chcp 1251\n${command}"}       
    
    def xddTestRunner = "${binary_data}/xddTestRunner.epf";
    
    stage "create admin user"
    echo "create admin user"
    command = """oscript ${vanessa_runner}/runner.os xunit ${binary_data}/tests/init --reportxunit "./build/init-report.xml" ${connstring} --pathxunit ${xddTestRunner} """ 
    if (isUnix()) {sh "${command}"} else {bat "chcp 1251\n${command}"}       
    
    step([$class: 'JUnitResultArchiver', testResults: '**/build/init-report.xml'])

    def user_pwd = """--db-user admin """;
    connstring = """${connstring} ${user_pwd} """;    

    stage "test"
    command = """oscript ${vanessa_runner}/runner.os xunit "${binary_data}/Tests/Utils" ${v8version} ${connstring} --pathxunit ${xddTestRunner}  --reportxunit ./build/report.xml"""
    // command = """oscript ${vanessa_runner}/runner.os xunit "${binary_data}/Tests" ${v8version} --ibname /F"./build/ib" --path ${xddTestRunner}  --report ./build/report.xml"""
    if (isUnix()){ sh "${command}" } else {bat "chcp 1251\n${command}"}

    step([$class: 'JUnitResultArchiver', testResults: '**/build/report.xml'])
    
    step([$class: 'ArtifactArchiver', artifacts: '**/build/out/**/*.epf', fingerprint: true])
    
    // stage "Проверка поведения BDD"
    // def testsettings = "VBParams837UF.json";
    // if (env.PATHSETTINGS) {
    //     testsettings = env.PATHSETTINGS;
    // }
    
    // // TODO:
    // // Придумать, как это сделать красиво и с учетом того, что задано в VBParams837UF.json
    // // Стр = Стр + " /Execute " + ПараметрыСборки["EpfДляИнициализацияБазы"] + " /C""InitDataBase;VBParams=" + ПараметрыСборки["ПараметрыДляИнициализацияБазы"] + """";
    // def VBParamsPath = pwd().replaceAll("%", "%%") + "/build/out/tools/epf/init.json"
    // command = """oscript ${vanessa_runner}/runner.os run ${v8version} --ibname /F"./build/ib" --execute "${binary_data}/tools/epf/init.epf" --command "InitDataBase;VBParams=${VBParamsPath}" """
    // def errors = []
    // try{
    //     if (isUnix()){
    //         sh "${command}"
            
    //     } else {
    //         bat "chcp 1251\n${command}"
    //     }
    // } catch (e) {
    //      errors << "BDD status : ${e}"
    // }

    // command = """oscript ${vanessa_runner}/runner.os vanessa ${v8version} --ibname /F"./build/ib" --path ${binary_data}/vanessa-behavior.epf --pathsettings ./tools/JSON/${testsettings} """
    // try{
    //     if (isUnix()){
    //         sh "${command}"
            
    //     } else {
    //         env.VANESSA_commandscreenshot='nircmd.exe savescreenshot '
    //         bat "chcp 1251\n${command}"
    //     }
    // } catch (e) {
    //      errors << "BDD status : ${e}"
    // }

    // command = """allure generate ${binary_data}/allurereport -o ./build/htmlpublish"""
    // if (isUnix()){ sh "${command}" } else {bat "chcp 1251\n${command}"}
    // publishHTML(target:[allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: './build/htmlpublish', reportFiles: 'index.html', reportName: 'Allure report'])

    // if (errors.size() > 0) {
    //     currentBuild.result = 'UNSTABLE'
    //     for (int i = 0; i < errors.size(); i++) {
    //         echo errors[i]; 
    //     }
    // } else {
    //     step([$class: 'ArtifactArchiver', artifacts: '**/build/out/*.epf', fingerprint: true])
    //     step([$class: 'ArtifactArchiver', artifacts: '**/build/out/features/Libraries/**/*.epf', fingerprint: true])
    //     step([$class: 'ArtifactArchiver', artifacts: '**/build/out/features/Libraries/**/*.feature', fingerprint: true])    
    // }

    stage "Publish releases"

    echo "stable if master, pre-release if have release, nigthbuild if develop"

}