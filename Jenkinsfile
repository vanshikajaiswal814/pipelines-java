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
                    DOCKER_IMAGE_NAME = 'your-docker-image-name'
                    DOCKER_HUB_USERNAME = 'your-docker-hub-username'
                    DOCKER_HUB_PASSWORD = 'your-docker-hub-password'
        }
        stage('Build Docker Image') {
                        steps {
                                script {
                                        docker.build("${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}")
                                }
                        }
        }
        stage('Push to Docker Hub') {
    steps {
        script {
            withCredentials([usernamePassword(credentialsId: 'DOCKER_HUB_CREDENTIALS', usernameVariable: 'jaiswal234', passwordVariable: 'Vanshika123')]) {
                docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-credentials') {
                    docker.image("${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                }
            }
        }
    }
}                                          
                            

        
            
             
    
}