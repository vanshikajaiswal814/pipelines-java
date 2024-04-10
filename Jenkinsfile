pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main',
                    url: 'https://gitlab.com/Vanshika90/pipelines-java.git'
            }
        }

        stage('Build') {
            steps {
                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }

        stage('Deploy') {
            when {
                branch 'development'
                expression {
                    return env.BRANCH_NAME == 'development'
                }
            }
            steps {
                echo "deploy stage"
                deploy adapters: [tomcat9(
                        credentialsId: 'tomcat',
                        path: '',
                        url: 'http://20.83.163.227:8088/'
                    )],
                    contextPath: 'text',
                    onFailure: 'false',
                    war: '**/*.war'
            }
        }

        stage('Install') {
            steps {
                sh 'mvn install'
            }
        }
    }
}