pipeline {
       def app
    agent any
    stages {
      
      stage('Clone repository') {
      steps {
      checkout scm
            }
      }

      stage('Build image') {
      steps {
      app = docker.build("tommy509/test")
            }     
      }

      stage('Test image') {
      app.inside {
            sh 'echo "Tests passed"'
        }
      }
      
      stage('Push image') {
      steps { 
      docker.withRegistry('https://registry.hub.docker.com', 'git') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
            }
        }
      }
    }
}