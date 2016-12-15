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
    // убрать вывод подробных сообщений
    //env.RUNNER_ENV="production";

    cmd('git config --system core.longpaths')
    cmd('git submodule update --init')
    
    //stage "checkout vanessa-runner"
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
        cmd(command)
    }
    
    stage "Сборка"
    
    def connstring = """--ibname /F"./build/ib" """;
    def binary_data = "./build/out";
	
    echo "build catalogs"
    command = """oscript ${vanessa_runner}/runner.os compileepf ${v8version} ${connstring} ./ ${binary_data}/ """
    cmd(command)
    
    def xddTestRunner = "${binary_data}/xddTestRunner.epf";
    
    stage "create admin user"
    echo "create admin user"
    command = """oscript ${vanessa_runner}/runner.os xunit ${binary_data}/tests/init --reportxunit "./build/init-report.xml" ${connstring} --pathxunit ${xddTestRunner} """ 
    cmd(command)
    
    step([$class: 'JUnitResultArchiver', testResults: '**/build/init-report.xml'])

    def user_pwd = """--db-user admin """;
    connstring = """${connstring} ${user_pwd} """;    

    stage "\u0422\u0435\u0441\u0442\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435"
    // stage "test"
    command = """oscript ${vanessa_runner}/runner.os xunit "${binary_data}/Tests" ${v8version} ${connstring} --pathxunit ${xddTestRunner}  --reportxunit ./build/report.xml"""
    cmd(command)

    step([$class: 'JUnitResultArchiver', testResults: '**/build/report.xml'])
    
    step([$class: 'ArtifactArchiver', artifacts: '**/build/out/**/*.epf', fingerprint: true])    

    stage "Publish releases"

    echo "stable if master, pre-release if have release, nigthbuild if develop"

}

def cmd(command) {
    if (isUnix()){ sh "${command}" } else {bat "chcp 1251\n${command}"}
}