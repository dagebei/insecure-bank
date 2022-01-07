pipeline {
  agent any

  environment {
    IO_POC_PROJECT_NAME = 'IO-POC-insecure-bank'
    IO_POC_PROJECT_VERSION = "1.0"
    POLARIS_ACCESS_TOKEN = credentials('polaris-token')
    BLACKDUCK_ACCESS_TOKEN = credentials('BlackDuck-AuthToken')
  }

  stages {
    stage('Build') {
      steps {
        sh 'mvn -e clean package -DskipTests'
      }
    }
    stage('SAST - Coverity') {
      steps {
        echo "Running Coverity on Polaris"
        sh '''
          rm -fr /tmp/polaris
          wget -q ${POLARIS_SERVER_URL}/api/tools/polaris_cli-linux64.zip
          unzip -j polaris_cli-linux64.zip -d /tmp
          /tmp/polaris --persist-config --co project.name="${IO_POC_PROJECT_NAME}" --co project.branch="main" --co capture.build.buildCommands="null" --co capture.build.cleanCommands="null" --co capture.fileSystem="null" --co capture.coverity.autoCapture="enable"  configure
          /tmp/polaris analyze -w
        '''
      }
    }
    stage('SCA - Blackduck') {
      steps {
        echo "Running Blackduck"
        sh '''
          rm -fr /tmp/detect7.sh
          curl -s -L https://detect.synopsys.com/detect7.sh > /tmp/detect7.sh
          bash /tmp/detect7.sh --blackduck.url="${BLACKDUCK_URL}" --blackduck.api.token="${BLACKDUCK_ACCESS_TOKEN}" --detect.project.name="${IO_POC_PROJECT_NAME}" --detect.project.version.name=${IO_POC_PROJECT_VERSION} --blackduck.trust.cert=true
        '''
      }
    }
    stage('Clean Workspace') {
      steps {
        cleanWs()
      }
    }
  }
}
