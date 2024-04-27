pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'jaiswal234/tomcatdocker'
        
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
stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'acr-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                        sh "docker push ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}"
                    }

                }
            }
        }

        
    }
}


