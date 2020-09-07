pipeline {
    agent {label 'slave'}

    stages {
        stage('Build') {
                steps {
                    sh 'docker build -f Dockerfile . -t mayarnour/dajangoappDev:v1.0'
                      }
                   post{
                    success{
                         slackSend(color: '#00FF00',message: "BuildingStarted: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'(${env.BUILD_URL}console)")
                      }
                  }
            }
        stage('Push') {
            steps {
                withCredentials([usernamePassword(credentialsId:"docker",usernameVariable:"USERNAME",passwordVariable:"PASSWORD")]){
                sh 'docker login --username $USERNAME --password $PASSWORD'
                sh 'docker push mayarnour/dajangoappDev:v1.0'
                }
            }
        }
         stage('Deploy') {
            steps {
                sh 'docker run -d -p 4000:3000 mayarnour/dajangoappDev:v1.0'
            }  
    }
  }
}
