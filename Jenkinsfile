pipeline {
  agent any

  environment {
    PROJECT = 'insecure-bank'
  }

  stages {
    stage('Build') {
      steps {
        sh 'mvn -e clean package -DskipTests'
      }
    }
    stage('SAST - Coverity') {
      steps {
        echo "add Polaris parts here"
      }
    }
    stage('SCA - Blackduck') {
      steps {
        echo "add Blackduck parts here"
      }
    }
    stage('Clean Workspace') {
      steps {
        cleanWs()
      }
    }
  }
}
