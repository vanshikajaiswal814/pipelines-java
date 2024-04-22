pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'tomcat-docker'
    }

    stages {
        stage('Checkout') {
            steps {
                // Get the code from the GitLab repository
                git branch: 'main',
                    url: 'https://gitlab.com/Vanshika90/pipelines-java.git'
            }
        }

        stage('Build') {
            environment {
                DOCKER_IMAGE_NAME = 'tomcat-docker'
            }
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

        stage('Build Docker Image') {
            
            steps {
                script {
                    docker.withRegistry('', 'docker-hub-credentials') {
                        docker.build("${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}")
                    }
                }
            }
        }

        stage('Push to Docker Hub') {
            
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                        docker.image("${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                    }
                }
            }
        }
    }
}