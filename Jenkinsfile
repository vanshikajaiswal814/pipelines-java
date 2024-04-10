pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Get the code from the GitLab repository
                git branch: 'development',
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
                branch 'development'
                expression {
                    return env.BRANCH_NAME == 'development'
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
                sh 'docker run --rm -v $PWD:/app -v jenkins-maven-repo:/root/.m2 -w /app tomcat:latest cp target/ROOT.war /usr/local/tomcat/webapps/'
            }
        }
    }
}