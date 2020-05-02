pipeline {
  agent any
    
  tools {nodejs "node"}
    
  stages {
        
    stage('Cloning Git') {
      steps {
        git 'https://github.com/tanyawms/udccapstone'
      }
    }
    stage('Create directories') {
      steps {
        sh '''
            mkdir -p /var/lib/jenkins/node/app/blue/node_modules
            cp /var/lib/jenkins/workspace/create-node-app/blue/package*.json /var/lib/jenkins/node/app/blue/
        '''
      }
    }
    stage('Install dependencies') {
      steps {
        sh 'npm install'
      }
    }
    stage('Test') {
      steps {
         sh 'npm test'
      }
    }      
  }
}
