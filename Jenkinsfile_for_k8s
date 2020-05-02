pipeline {
	agent any
	stages {

        stage('Set current kubectl context') {
			steps {
				withAWS(region:'us-east-2', credentials:'capstone-credentials') {
					sh '''
						kubectl config use-context arn:aws:eks:us-east-2:121275816552:cluster/capcluster
					'''
				}
			}
		}

		stage('Deploy blue container') {
			steps {
				withAWS(region:'us-east-2', credentials:'capstone-credentials') {
					sh '''
						kubectl apply -f ./blue-controller.json
					'''
				}
			}
		}

		stage('Deploy green container') {
			steps {
				withAWS(region:'us-east-2', credentials:'capstone-credentials') {
					sh '''
						kubectl apply -f ./green-controller.json
					'''
				}
			}
		}

		stage('Create the service in the cluster, redirect to blue') {
			steps {
				withAWS(region:'us-east-2', credentials:'capstone-credentials') {
					sh '''
						kubectl apply -f ./blue-service.json
					'''
				}
			}
		}

	}
}
