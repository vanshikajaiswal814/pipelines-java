pipeline {

 agent {
        docker {
            image 'jenkins/agent:latest'
            args '-v /tmp:/tmp'
        }
    }


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
            docker.image('aquasec/trivy:latest').pull()
        }
    }
}
        stage('Scan Docker Image') {
    steps {
        script {
            def trivyScan = docker.image('aquasec/trivy:latest').inside("--security-opt seccomp=unconfined --entrypoint=''") {
                sh "trivy image ${ACR_URL}/${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}"
            }
            if (trivyScan.exitStatus != 0) {
                error "Security scan failed. Please check the vulnerabilities."
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
