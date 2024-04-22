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
        environment {
                    DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
                    DOCKER_IMAGE_NAME = 'tomcat-docker'
                    DOCKER_HUB_USERNAME = 'jaiswal234'
                    DOCKER_HUB_PASSWORD = 'Vanshika123'
        }
        stage('Build Docker Image') {
                        steps {
                                script {
                                        docker.build("${tomcat-docker}:${env.BUILD_NUMBER}")
                                }
                        }
        }
        stage('Push to Docker Hub') {
    steps {
        script {
            withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB_CREDENTIALS', usernameVariable: 'jaiswal234', passwordVariable: 'Vanshika123')]) {
                docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                    docker.image("${tomcat-docker}:${env.BUILD_NUMBER}").push()
                }
            }
        }
    }
}                                          
                            

        
            
             
    
}