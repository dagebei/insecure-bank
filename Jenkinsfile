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
    IS_SAST_ENABLED = "false"
    IS_SCA_ENABLED = "false"
    IS_DAST_ENABLED = "false"
    IS_IMAGE_SCAN_ENABLED = "false"
    IS_CODE_REVIEW_ENABLED = "false"
    IS_PEN_TESTING_ENABLED = "false"
  }

  stages {
    stage('Build') {
      steps {
        sh 'mvn -e clean package -DskipTests'
      }
    }
    stage('IO Prescription') {
      steps {
        echo "Getting IO Prescription"
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
          --IS_SAST_ENABLED="${IS_SAST_ENABLED}" \
          --IS_SCA_ENABLED="${IS_SCA_ENABLED}" \
          --IS_DAST_ENABLED="${IS_DAST_ENABLED}"
        '''
        sh '''
          echo "==================================== IO Risk Score =======================================" > io-risk-score.txt
          echo "Business Criticality Score - $(jq -r '.riskScoreCard.bizCriticalityScore' result.json)" >> io-risk-score.txt
          echo "Data Class Score - $(jq -r '.riskScoreCard.dataClassScore' result.json)" >> io-risk-score.txt
          echo "Access Score - $(jq -r '.riskScoreCard.accessScore' result.json)" >> io-risk-score.txt
          echo "Open Vulnerability Score - $(jq -r '.riskScoreCard.openVulnScore' result.json)" >> io-risk-score.txt
          echo "Change Significance Score - $(jq -r '.riskScoreCard.changeSignificanceScore' result.json)" >> io-risk-score.txt
          export bizScore=$(jq -r '.riskScoreCard.bizCriticalityScore' result.json | cut -d'/' -f2) 
          export dataScore=$(jq -r '.riskScoreCard.dataClassScore' result.json | cut -d'/' -f2)
          export accessScore=$(jq -r '.riskScoreCard.accessScore' result.json | cut -d'/' -f2)
          export vulnScore=$(jq -r '.riskScoreCard.openVulnScore' result.json | cut -d'/' -f2)
          export changeScore=$(jq -r '.riskScoreCard.changeSignificanceScore' result.json | cut -d'/' -f2)
          echo -n "Total Score - " >> io-risk-score.txt && echo "$bizScore + $dataScore + $accessScore + $vulnScore + $changeScore" | bc >> io-risk-score.txt
        '''
        sh 'cat io-risk-score.txt'
        sh '''
          IS_SAST_ENABLED=$(jq -r '.security.activities.sast.enabled' result.json)
          IS_SCA_ENABLED=$(jq -r '.security.activities.sca.enabled' result.json)
          IS_DAST_ENABLED=$(jq -r '.security.activities.dast.enabled' result.json)
          IS_IMAGE_SCAN_ENABLED=$(jq -r '.security.activities.imageScan.enabled' result.json)
          IS_CODE_REVIEW_ENABLED=$(jq -r '.security.activities.sastplusm.enabled' result.json)
          IS_PEN_TESTING_ENABLED=$(jq -r '.security.activities.dastplusm.enabled' result.json)
        '''
      }
    }
    stage('SAST - Coverity') {
      steps {
        echo "Running Coverity on Polaris"
        sh '''
          echo "IS_SAST_ENABLED = ${IS_SAST_ENABLED}"
          IS_SAST_ENABLED=$(jq -r '.security.activities.sast.enabled' result.json)
          echo "IS_SAST_ENABLED = ${IS_SAST_ENABLED}"
          if [ ${IS_SAST_ENABLED} ]; then
            echo "Running Coverity on Polaris based on IO Precription"
          else
            echo "Skipping Coverity on Polaris based on IO Precription"
          fi
        '''
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
        echo "IS_SCA_ENABLED = ${IS_SCA_ENABLED}"
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
