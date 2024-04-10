pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Get the code from the GitLab repository
                git branch: 'main',
                    url: 'https://gitlab.com/Vanshika90/pipelines-java.git'
            }
        }

        stage('Build') {
            steps {
                // Run Maven to build the project
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                // Run the tests
                sh 'mvn test'
            }
        }

        stage('Install') {
            when {
                branch 'develop'
                expression {
                    return env.BRANCH_NAME == 'develop'
                }
            }
            steps {
                // Install the built artifacts to the local Maven repository
                sh 'mvn install'
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
                expression {
                    return env.BRANCH_NAME == 'main'
                }
            }
            steps {
                // Deploy the war file to Tomcat
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
        }
    }
}