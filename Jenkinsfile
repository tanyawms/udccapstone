pipeline {
	agent any
	stages {

        stage('Set current kubectl context') {
			steps {
				withAWS(region:'us-east-2', credentials:'capstone-credentials') {
					sh '''
						kubectl config use-context arn:aws:eks:us-east-2:121275816552:cluster/capstone
					'''
				}
			}
		}

		stage('Add blue container') {
			steps {
				withAWS(region:'us-east-2', credentials:'capstone-credentials') {
					sh '''
						kubectl apply -f ./blue-controller.yml
					'''
				}
			}
		}

		stage('Add green container') {
			steps {
				withAWS(region:'us-east-2', credentials:'capstone-credentials') {
					sh '''
						kubectl apply -f ./green-controller.yml
					'''
				}
			}
		}

		stage('Deploy the blue container in the cluster') {
			steps {
				withAWS(region:'us-east-2', credentials:'capstone-credentials') {
					sh '''
						kubectl apply -f ./blue-deployment.yml
					'''
				}
			}
		}
                stage('Deploy the green container in the cluster') {
                        steps {
                                withAWS(region:'us-east-2', credentials:'capstone-credentials') {
                                        sh '''
                                                kubectl apply -f ./green-deployment.yml
                                        '''
                                }
                        }
                }
                stage('Deploy the service in the cluster, point to blue') {
                        steps {
                                withAWS(region:'us-east-2', credentials:'capstone-credentials') {
                                        sh '''
                                                kubectl apply -f ./blue-service.yml
                                        '''
                                }
                        }
                }
                stage('Wait user approve') {
                        steps {
                                input "Ready to redirect traffic to green?" 
                              }
                }
                stage('Switch the service to green') {
                        steps {
                                withAWS(region:'us-east-2', credentials:'capstone-credentials') {
                                        sh '''
                                                kubectl apply -f ./green-service.yml
                                        '''
                                }
                        }
                }

	}
}
