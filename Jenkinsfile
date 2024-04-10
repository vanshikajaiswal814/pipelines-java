pipeline {
        agent any

            stages {
                        stage('Build') {
                                        steps {
                                                            sh 'mvn clean package'
                                        }
                        }
                                stage('Test') {
                                                steps {
                                                                    sh 'mvn test'
                                                }
                                }
            }

                when {
                            branch 'development'
                                    expression {
                                                    return env.BRANCH_NAME == 'development'
                                    }
                }

                    stage('Install') {
                                steps {
                                                sh 'mvn install'
                                }
                    }

                        when {
                                    branch 'main'
                                            expression {
                                                            return env.BRANCH_NAME == 'main'
                                            }
                        }

                            stage('Deploy') {
                                        steps {
                                                        sh 'docker run --rm -v $PWD:/app -v jenkins-maven-repo:/root/.m2 -w /app tomcat:latest cp target/ROOT.war /usr/local/tomcat/webapps/'
                                        }
                            }
}
                                        }
                            }
                                            }
                        }
                                }
                    }
                                    }
                }
                                                }
                                }
                                        }
                        }
            }
}