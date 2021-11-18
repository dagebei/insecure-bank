pipeline {
  agent any

  environment {
    PROJECT = 'insecure-bank'
  }

//  tools {
//    jdk 'openjdk-11'
//  }

  stages {
    stage('clean') {
      steps {
        cleanWs()
      }
    }
    stage('Build') {
      steps {
        sh 'mvn -e clean package -DskipTests'
      }
    }
  }
}
