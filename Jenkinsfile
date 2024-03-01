pipeline {
    agent any

    stages {
         
        stage('Checkout') {
            
            steps {
                // Get some code from a GitHub repository
                git branch: 'main',
                    url: 'https://gitlab.com/Vanshika90/pipelines-java.git'

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
            stage ('email config') {

        steps {
                mail bcc: '', body: 'mail from jenkins', cc: '', from: '', replyTo: '', subject: 'jenkins email', to: 'vanshikajaiswalvns@gmail.com'
        }
    }

    }
}
