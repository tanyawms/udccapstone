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

		stage('Deploy blue container') {
			steps {
				withAWS(region:'us-east-2', credentials:'capstone-credentials') {
					sh '''
						kubectl apply -f ./blue-controller.yml
					'''
				}
			}
		}

		stage('Deploy green container') {
			steps {
				withAWS(region:'us-east-2', credentials:'capstone-credentials') {
					sh '''
						kubectl apply -f ./green-controller.yml
					'''
				}
			}
		}

		stage('Create the blue service in the cluster') {
			steps {
				withAWS(region:'us-east-2', credentials:'capstone-credentials') {
					sh '''
						kubectl apply -f ./blue-service.yml
					'''
				}
			}
		}
                stage('Deploy the service in the cluster, point to blue') {
                        steps {
                                withAWS(region:'us-east-2', credentials:'capstone-credentials') {
                                        sh '''
                                                kubectl apply -f ./blue-deployment.yml
                                        '''
                                }
                        }
                }

	}
}
