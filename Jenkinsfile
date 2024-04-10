pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Install') {
            when {
                branch 'main'
                expression {
                    return env.BRANCH_NAME == 'main'
                }
            }
            steps {
                sh 'mvn install'
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
                sh 'docker run --rm -v $PWD:/app -v jenkins-maven-repo:/root/.m2 -w /app tomcat:latest cp target/ROOT.war /usr/local/tomcat/webapps/'
            }
        }
    }
}