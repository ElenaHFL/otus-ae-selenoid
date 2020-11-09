pipeline {
    agent any

    triggers {
        cron('0 1 * * *')
        githubPush()
    }

    parameters {
        credentials(
            credentialType: 'com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl', 
            defaultValue: 'f7a64bf6-6c24-491d-ab89-caf15d0b5976', 
            description: 'select user for test', 
            name: 'user', 
            required: false
            ) 
    }

    stages {
        stage('Pull from GitHub') {
            steps {
                git ([
                    url: 'https://github.com/ElenaHFL/otus-ae-selenoid.git'
                    ])
            }
        }
        stage('Run maven clean') {
            steps {
                bat 'mvn clean'
            }
        }
        stage('Run test') {
            steps {
                bat 'mvn test'
            }
        }    
        stage('Backup and Reports') {
            steps {
                archiveArtifacts artifacts: '**/target/', fingerprint: true 
            }
            post {
                always {
                  script {
                    // Формирование отчета
                    allure([
                      includeProperties: false,
                      jdk: '',
                      properties: [],
                      reportBuildPolicy: 'ALWAYS',
                      results: [[path: 'target/allure-results']]
                    ])

                    // Узнаем ветку репозитория (т.к. это не multipipeline job, то вариант через env.BRANCH_NAME увы не работает)
                    def branch = bat(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD\n').trim().tokenize().last()
                       
                    // Делаем симпотичное время выполнения 
                    def duration = "${currentBuild.durationString.minus(' секунд and counting')} seconds"
                      
                    // Достаем информацию по тестам из junit репорта
                    def summary = junit testResults: '**/target/surefire-reports/*.xml'
                      
                    // Текст оповещения
                    def message = "${currentBuild.currentResult}: Job ${env.JOB_NAME}, build ${env.BUILD_NUMBER}, branch ${branch}\nDuration - ${duration}\nTest Summary - ${summary.totalCount}, Failures: ${summary.failCount}, Skipped: ${summary.skipCount}, Passed: ${summary.passCount}\nMore info at: ${env.BUILD_URL}"
                    
                    // Отправка результатов на почту
                    emailext body: "${message}",
                        recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                        subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}",
                        to: 'elenaa@hflabs.ru'
                        
                    // Отправка результатов В slack
                    slackSend(
                        message: "${message}",
                        channel: "qa-java-2020-06"
                    )
                  }
                }
            }
        }
    }
}
