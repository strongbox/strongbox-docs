@Library('jenkins-shared-libraries') _

// Notification settings for "master" and "branch/pr"
def notifyMaster = [notifyAdmins: true, recipients: [culprits(), requestor()]]
def notifyBranch = [recipients: [brokenTestsSuspects(), requestor()]]

pipeline {
    agent {
        node {
            label 'alpine:mkdocs'
            customWorkspace workspace().getUniqueWorkspacePath()
        }
    }
    environment {
        DEPLOY_URL="https://strongbox.github.io"
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
    }
    stages {
        stage('Node')
        {
            steps {
                nodeInfo("python pip mkdocs")
            }
        }
        stage('Building')
        {
            steps {
                withCredentials([string(credentialsId: '3ea1e18a-b1d1-44e0-a1ff-7b62870913f8', variable: 'GOOGLE_ANALYTICS_KEY')]) {
                    sh "mkdocs build"
                }
            }
        }
        stage('Deploying') {
            when {
                expression { BRANCH_NAME == 'master' && (currentBuild.result == null || currentBuild.result == 'SUCCESS') }
            }
            steps {
                configFileProvider([configFile(fileId: 'e0235d92-c2fc-4f81-ae4b-28943ed7350d', targetLocation: '/tmp/gh-pages.sh')]) {
                    withCredentials([sshUserPrivateKey(credentialsId: '011f2a7d-2c94-48f5-92b9-c07fd817b4be', keyFileVariable: 'SSH_KEY', usernameVariable: 'SSH_USER')]) {
                        withEnv(["GIT_SSH_COMMAND=ssh -o StrictHostKeyChecking=no -o User=${SSH_USER} -i ${SSH_KEY}"]) {
                            sh "/bin/bash /tmp/gh-pages.sh"
                        }
                    }
                }
            }
        }
    }
    post {
        cleanup {
            script {
                workspace().clean()
            }
        }
    }
}
