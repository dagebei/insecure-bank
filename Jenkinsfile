pipeline {
  agent any

  environment {
    PROJECT = 'insecure-bank'
    POLARIS_ACCESS_TOKEN = credentials('polaris-token')
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
        echo "${POLARIS_SERVER_URL}"
        sh '''
          wget -q ${POLARIS_SERVER_URL}/api/tools/polaris_cli-linux64.zip
          unzip -j polaris_cli-linux64.zip -d /tmp
          /tmp/polaris --persist-config --co project.name="IO-POC-insecure-bank" --co capture.build.buildCommands="null" --co capture.build.cleanCommands="null" --co capture.fileSystem="null" --co capture.coverity.autoCapture="enable"  configure
          /tmp/polaris analyze -w
          rm /tmp/polaris
        '''
      }
    }
    stage('SCA - Blackduck') {
      steps {
        echo "add Blackduck parts here"
        echo "${BLACKDUCK_URL}"
      }
    }
    stage('CodeDx') {
      steps {
        echo "add CodeDx parts here"
        echo "${CODEDX_SERVER_URL}"
      }
    }
    stage('Clean Workspace') {
      steps {
        cleanWs()
      }
    }
  }
}
