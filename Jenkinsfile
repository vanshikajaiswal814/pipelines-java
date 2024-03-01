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
          }
}
