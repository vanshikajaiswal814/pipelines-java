pipeline {
    agent any

    stages {
         
        stage('Checkout') {
            
            steps {
                // Get some code from a GitHub repository
                git branch: 'main',
                    url: 'https://gitlab.com/nravinuthala/pipelines-java.git'

             }
        }

        // stage('Verify') {
            
        //     steps {
        //         sh "mvn verify sonar:sonar \
        //             -Dsonar.host.url=http://20.172.200.178:9000 \
        //             -Dsonar.projectKey=nravinuthala_pipelines-java_AYob7vqrC0mdZlzzBssl \
        //             -Dsonar.login=sqp_9c73bbe5db7c59de59e599d196f98b7e510ad7b5"

        //      }
        // }
        
        stage ('Test') {

            steps {
                // Run Maven on a Unix agent.
                sh "mvn surefire-report:report"
            
                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

        }

        stage ('Build') {

            steps {
                // Run Maven on a Unix agent.
                sh "mvn -Dmaven.test.failure.ignore=true package"

                // To run Maven on a Windows agent, use
                // bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }

        }

        // stage ('Deploy') {

        //     steps {
        //         echo "deploy stage"
        //         deploy adapters: [tomcat9 (
        //                 credentialsId: 'tomcat_deploy_ui',
        //                 path: '',
        //                 url: 'http://20.62.99.46:8080/'
        //             )],
        //             contextPath: 'servletjar11111',
        //             onFailure: 'false',
        //             war: '**/*.war'
        //     }
        //     post {
        //         // If Maven was able to run the tests, even if some of the test
        //         // failed, record the test results and archive the jar file.
        //         success {
        //             junit '**/target/surefire-reports/TEST-*.xml'
        //             archiveArtifacts 'target/*.war'
        //         }
        //     }
        // }
    }
}
