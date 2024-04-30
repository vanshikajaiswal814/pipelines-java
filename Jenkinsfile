pipeline {

 agent any

    environment {
        DOCKER_IMAGE_NAME = 'tomcatdocker'
        ACR_NAME = 'vanshikacon'
        ACR_URL = "${ACR_NAME}.azurecr.io"
    }
    


    stages {
        stage('Checkout') {
            steps {
                // Get the code from the GitLab repository
                git branch: 'main',
                    url: 'https://gitlab.com/Vanshika90/pipelines-java.git'
            }
        }
       

        stage('Test') {
            steps {
                // Run Maven on a Unix agent.
                sh "mvn test"
            }
        }

        stage('Build') {
            steps {
                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${ACR_URL}/${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Pull Trivy Image') {
    steps {
        script {
            docker.withRegistry("https://registry.hub.docker.com", 'docker-hub-credentials') {
                docker.image('aquasec/trivy:latest').pull()
            }
        }
    }
}
        stage('Scan Docker Image') {
    steps {
        script {
            def trivyImage = docker.image('aquasec/trivy:latest')
            trivyImage.pull()
            trivyImage.inside("-v /var/run/docker.sock:/var/run/docker.sock") {
                sh "trivy image ${ACR_URL}/${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}"
            }
        }
    }
}


        

        stage('Push to ACR') {
            steps {
                script {
                    docker.withRegistry("https://${ACR_URL}", 'acr-credentials') {
                        docker.image("${ACR_URL}/${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}").push()
                    }
                }
            }
        }
    }
}
