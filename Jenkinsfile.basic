pipeline {
  agent any

  environment {
    IO_POC_PROJECT_NAME = 'IO-POC-insecure-bank'
    IO_POC_PROJECT_VERSION = "1.0"
  }

  stages {
    stage('Build') {
      steps {
        sh 'mvn -e clean package -DskipTests'
      }
    }
    stage('Clean Workspace') {
      steps {
        cleanWs()
      }
    }
  }
}
