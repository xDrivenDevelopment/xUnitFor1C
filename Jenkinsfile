#!groovy
node("slave") {
    // ВНИМАНИЕ:
    // Jenkins и его ноды нужно запускать с кодировкой UTF-8
    //      строка конфигурации для запуска Jenkins
    //      <arguments>-Xrs -Xmx256m -Dhudson.lifecycle=hudson.lifecycle.WindowsServiceLifecycle -Dmail.smtp.starttls.enable=true -Dfile.encoding=UTF-8 -jar "%BASE%\jenkins.war" --httpPort=8080 --webroot="%BASE%\war" </arguments>
    //
    //      строка для запуска нод
    //      @"C:\Program Files (x86)\Jenkins\jre\bin\java.exe" -Dfile.encoding=UTF-8 -jar slave.jar -jnlpUrl http://localhost:8080/computer/slave/slave-agent.jnlp -secret XXX
    //      подставляйте свой путь к java, порту Jenkins и секретному ключу
    //
    // Если запускать Jenkins не в режиме UTF-8, тогда нужно поменять метод cmd в конце кода, применив комментарий к методу

    stage "Получение исходных кодов"
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

    stage "Создание тестовой ИБ"

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
    
    stage "Сборка из исходников"
    
    def connstring = """--ibname /F"./build/ib" """;
    def binary_data = "./build/out";
	
    echo "build catalogs"
    command = """oscript ${vanessa_runner}/runner.os compileepf ${v8version} ${connstring} ./ ${binary_data}/ """
    cmd(command)
    
    def xddTestRunner = "${binary_data}/xddTestRunner.epf";
    
    stage "Создание пользователя-администратора"
    
    echo "create admin user"
    command = """oscript ${vanessa_runner}/runner.os xunit ${binary_data}/tests/init --reportxunit "./build/init-report.xml" ${connstring} --pathxunit ${xddTestRunner} """ 
    cmd(command)
    
    step([$class: 'JUnitResultArchiver', testResults: '**/build/init-report.xml'])

    def user_pwd = """--db-user admin """;
    connstring = """${connstring} ${user_pwd} """;    

    stage "Тестирование"

    command = """oscript ${vanessa_runner}/runner.os xunit "${binary_data}/Tests" ${v8version} ${connstring} --pathxunit ${xddTestRunner}  --reportxunit ./build/report.xml"""
    cmd(command)

    stage "Сборка поставки"
    step([$class: 'JUnitResultArchiver', testResults: '**/build/report.xml'])
    
    step([$class: 'ArtifactArchiver', artifacts: '**/build/out/**/*.epf', fingerprint: true])    

    // stage "Публикация релиза"

    // echo "stable if master, pre-release if have release, nigthbuild if develop"

}

def cmd(command) {
    // TODO при запуске Jenkins не в режиме UTF-8 нужно написать chcp 1251 вместо chcp 65001
    if (isUnix()){ sh "${command}" } else {bat "chcp 65001\n${command}"}
}