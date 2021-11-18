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
    stage('IO Prescription') {
      steps {
        echo "add IO Prescription parts here"
      }
    }
    stage('SAST - Coverity') {
      steps {
        echo "add Polaris parts here"
        echo $POLARIS_SERVER_URL
      }
    }
    stage('SCA - Blackduck') {
      steps {
        echo "add Blackduck parts here"
        echo $BLACKDUCK_URL
      }
    }
    stage('CodeDx') {
      steps {
        echo "add CodeDx parts here"
        echo $CODEDX_SERVER_URL      }
    }
    stage('Clean Workspace') {
      steps {
        cleanWs()
      }
    }
  }
}
