pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'tomcatdocker'
        
    }

    stages {
        stage('Checkout') {
            steps {
                // Get the code from the GitLab repository
                git branch: 'main',
                    url: 'https://gitlab.com/Vanshika90/pipelines-java.git'
            }
        }

        stage ('Test') {

            steps {
                // Run Maven on a Unix agent.
                sh "mvn test"
            
                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

        }

        stage ('Build') {

            steps {
                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }

stage('Build Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://vanshikacon.azurecr.io', 'acr-credentials') {
                        docker.build("${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}")
                    }
                }
            }
        }
stage('Push to ACR') {
            steps {
                script {
                    docker.withRegistry("https://${REGISTRY}", 'acr-credentials') {
                        docker.image("https://vanshikacon.azurecr.io/${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                    }
                }
            }
        }
    
        
    }
}


