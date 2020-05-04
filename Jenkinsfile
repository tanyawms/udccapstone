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

		stage('Deploy the blue container in the cluster') {
			steps {
				withAWS(region:'us-east-2', credentials:'capstone-credentials') {
					sh '''
						kubectl apply -f ./blue.yaml
					'''
				}
			}
		}
                stage('Deploy the green container in the cluster') {
                        steps {
                                withAWS(region:'us-east-2', credentials:'capstone-credentials') {
                                        sh '''
                                                kubectl apply -f ./green.yaml
                                        '''
                                }
                        }
                }
                stage('Deploy the service in the cluster, point to blue') {
                        steps {
                                withAWS(region:'us-east-2', credentials:'capstone-credentials') {
                                        sh '''
                                                kubectl apply -f ./service.yaml
                                        '''
                                }
                        }
                }

	}
}