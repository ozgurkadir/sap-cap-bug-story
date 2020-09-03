@Library('piper-lib-os') _
node() {
    stage('prepare') {
        checkout scm
        setupCommonPipelineEnvironment script:this
    }

    stage('build') {
        mtaBuild script: this
    }

    withCredentials([string(credentialsId: 'CF_ORG', variable: 'CF_ORG_V'), string(credentialsId: 'CF_SPACE', variable: 'CF_SPACE_V')]) {
        stage('deploy') {
            cloudFoundryDeploy script: this
        }
    }
}