
                    
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

        stage ('Deploy') {

            steps {
                echo "deploy stage"
                deploy adapters: [tomcat9 (
                        credentialsId: '123',
                        path: '',
                        url: 'http://20.42.57.77:8088/'
                    )],
                    contextPath: 'text',
                    onFailure: 'false',
                    war: '**/*.war'
            }
            post {
                // If Maven was able to run the tests, even if some of the test
                // failed, record the test results and archive the jar file.
                success {
                    junit '**/target/surefire-reports/TEST-*.xml'
                    archiveArtifacts 'target/*.war'
                }
            }
        }
    }
}


