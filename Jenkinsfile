pipeline {
        agent any
          stages {
                    stage('Preparation') {
                        steps {
                                script {
                                         // Checkout code from Git repository
                                           checkout scm

                                }
                               }
                      }
                       stage('Build') {
                                       steps {
                                                script {
                                                         // Maven build
                                                         sh 'mvn clean install'
                                                }

                                             }
                                     
                                     }
                       stage('Test') {
                            steps {
                                     script {
                                                // Run JUnit tests
                                                   sh 'mvn test'
                                     }

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
                contextPath: 'test',
                onFailure: 'false',
                war: '**/*.war'
        }
    }

          }
}
