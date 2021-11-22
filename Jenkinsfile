pipeline {
  agent any

  environment {
    IO_POC_PROJECT_NAME = 'IO-POC-insecure-bank'
    IO_POC_PROJECT_VERSION = "1.0"
    POLARIS_ACCESS_TOKEN = credentials('polaris-token')
    BLACKDUCK_ACCESS_TOKEN = credentials('BlackDuck-AuthToken')
    IO_ACCESS_TOKEN = credentials('IO-AUTH-TOKEN')
    GTIHUB_ACCESS_TOKEN = credentials('Github-AuthToken')
    CODEDX_ACCESS_TOKEN = credentials('CODEDX_API_KEY')
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
        sh '''
          rm -fr prescription.sh
          wget "https://raw.githubusercontent.com/synopsys-sig/io-artifacts/${WORKFLOW_CLIENT_VERSION}/prescription.sh"
          sed -i -e 's/\r$//' prescription.sh
          chmod a+x prescription.sh
          ./prescription.sh \
          --stage="IO" \
          --persona="devsecops" \
          --io.url="${IO_URL}" \
          --io.token="${IO_ACCESS_TOKEN}" \
          --manifest.type="json" \
          --asset.id="insecure-bank" \
          --workflow.url="${WORKFLOW_URL}" \
          --workflow.version="2021.10.1" \
          --file.change.threshold="10" \
          --sast.rescan.threshold="20" \
          --sca.rescan.threshold="20" \
          --scm.type="github" \
          --scm.owner="dagebei" \
          --scm.repo.name="insecure-bank" \
          --scm.branch.name="main" \
          --github.username="dagebei" \
          --github.token="${GTIHUB_ACCESS_TOKEN}" \
          --polaris.project.name="${IO_POC_PROJECT_NAME}" \
          --polaris.url="${POLARIS_SERVER_URL}" \
          --polaris.token="${POLARIS_ACCESS_TOKEN}" \
          --blackduck.project.name="${IO_POC_PROJECT_NAME}:${IO_POC_PROJECT_VERSION}" \
          --blackduck.url="${BLACKDUCK_URL}" \
          --blackduck.api.token="${BLACKDUCK_ACCESS_TOKEN}" \
          --jira.enable="false" \
          --codedx.url="${CODEDX_SERVER_URL}" \
          --codedx.api.key="${CODEDX_ACCESS_TOKEN}" \
          --codedx.project.id="5" \
          --IS_SAST_ENABLED="false" \
          --IS_SCA_ENABLED="false" \
          --IS_DAST_ENABLED="false"
        '''
      }
    }
    stage('SAST - Coverity') {
      steps {
        echo "Running Coverity on Polaris"
        /*
        sh '''
          rm -fr /tmp/polaris
          wget -q ${POLARIS_SERVER_URL}/api/tools/polaris_cli-linux64.zip
          unzip -j polaris_cli-linux64.zip -d /tmp
          /tmp/polaris --persist-config --co project.name="${IO_POC_PROJECT_NAME}" --co capture.build.buildCommands="null" --co capture.build.cleanCommands="null" --co capture.fileSystem="null" --co capture.coverity.autoCapture="enable"  configure
          /tmp/polaris analyze -w
        '''
        */
      }
    }
    stage('SCA - Blackduck') {
      steps {
        echo "Running Blackduck"
        /*
        sh '''
          rm -fr /tmp/detect7.sh
          curl -s -L https://detect.synopsys.com/detect7.sh > /tmp/detect7.sh
          bash /tmp/detect7.sh --blackduck.url="${BLACKDUCK_URL}" --blackduck.api.token="${BLACKDUCK_ACCESS_TOKEN}" --detect.project.name="${IO_POC_PROJECT_NAME}" --detect.project.version.name=${IO_POC_PROJECT_VERSION} --blackduck.trust.cert=true
        '''
        */
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
