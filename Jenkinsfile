pipeline {
  agent any

  environment {
    PROJECT = 'insecure-bank'
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
          ./prescription.sh \
          --stage="IO" \
          --persona="devsecops" \
          --io.url="${IO_URL}" \
          --io.token="${IO_ACCESS_TOKEN}" \
          --manifest.type="json" \
          --asset.id="insecure-bank" \
          --workflow.url="http://52.186.143.163/api/workflowengine/" \
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
          --polaris.project.name="IO-POC-insecure-bank" \
          --polaris.url="https://sipse.polaris.synopsys.com/" \
          --polaris.token="${POLARIS_ACCESS_TOKEN}" \
          --blackduck.project.name="IO-POC-insecure-bank:1.0" \
          --blackduck.url="https://testing.blackduck.synopsys.com" \
          --blackduck.api.token="${BLACKDUCK_ACCESS_TOKEN}" \
          --jira.enable="false" \
          --codedx.url="http://52.186.143.163:18080/codedx" \
          --codedx.api.key="${CODEDX_ACCESS_TOKEN}" \
          --codedx.project.id="5" \
          --IS_SAST_ENABLED="false" \
          --IS_SCA_ENABLED="false" \
          --IS_DAST_ENABLED="false"

          /tmp/polaris --persist-config --co project.name="IO-POC-insecure-bank" --co capture.build.buildCommands="null" --co capture.build.cleanCommands="null" --co capture.fileSystem="null" --co capture.coverity.autoCapture="enable"  configure
          /tmp/polaris analyze -w
        '''
      }
    }
    stage('SAST - Coverity') {
      steps {
        echo "Running Coverity on Polaris"
        sh '''
          rm -fr /tmp/polaris
          wget -q ${POLARIS_SERVER_URL}/api/tools/polaris_cli-linux64.zip
          unzip -j polaris_cli-linux64.zip -d /tmp
          /tmp/polaris --persist-config --co project.name="IO-POC-insecure-bank" --co capture.build.buildCommands="null" --co capture.build.cleanCommands="null" --co capture.fileSystem="null" --co capture.coverity.autoCapture="enable"  configure
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
          bash /tmp/detect7.sh --blackduck.url="${BLACKDUCK_URL}" --blackduck.api.token="${BLACKDUCK_ACCESS_TOKEN}" --detect.project.name="IO-POC-insecure-bank" --detect.project.version.name=1.0 --blackduck.trust.cert=true
        '''
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
