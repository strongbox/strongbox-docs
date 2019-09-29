@Library('jenkins-shared-libraries') _

// Notification settings for "master" and "branch/pr"
def notifyMaster = [notifyAdmins: true, recipients: [culprits(), requestor()]]
def notifyBranch = [recipients: [brokenTestsSuspects(), requestor()]]

pipeline {
    agent {
        node {
            label 'alpine-mkdocs'
        }
    }
    environment {
        DEPLOY_URL = "https://strongbox.github.io"
    }
    options {
        timeout(time: 30, unit: 'MINUTES')
        disableConcurrentBuilds()
    }
    stages {
        stage('Node') {
            steps {
                container("mkdocs") {
                    nodeInfo("python pip mkdocs")
                }
            }
        }
        stage('Building') {
            steps {
                container("mkdocs") {
                    withCredentials([string(credentialsId: '3ea1e18a-b1d1-44e0-a1ff-7b62870913f8', variable: 'GOOGLE_ANALYTICS_KEY')]) {
                        sh "mkdocs build"
                    }
                }
            }
        }
        stage('Deploying') {
            when {
                expression {
                    BRANCH_NAME == 'master' && (currentBuild.result == null || currentBuild.result == 'SUCCESS')
                }
            }
            steps {
                container("mkdocs") {
                    withCredentials([sshUserPrivateKey(credentialsId: '011f2a7d-2c94-48f5-92b9-c07fd817b4be', keyFileVariable: 'SSH_KEY', usernameVariable: 'SSH_USER')]) {
                        withEnv(["GIT_SSH_COMMAND=ssh -o StrictHostKeyChecking=no -o User=${SSH_USER} -i ${SSH_KEY}"]) {
                            sh 'git checkout --orphan gh-pages'
                            sh 'find . -maxdepth 1 ! -name "site" ! -name ".git*" ! -name "." -exec git rm -rf {} \\;'
                            sh 'git add --force site'
                            sh 'git commit -m "Updating documentation site."'
                            sh 'git remote add strongbox.github.io git@github.com:strongbox/strongbox.github.io.git'
                            sh 'git push strongbox.github.io `git subtree split --prefix site gh-pages`:master --force'
                        }
                    }
                }
            }
        }
    }
    post {
        failure {
            script {
                if (params.NOTIFY_EMAIL)
                {
                    notifyFailed((BRANCH_NAME == "master") ? notifyMaster : notifyBranch)
                }
            }
        }
        fixed {
            script {
                if (params.NOTIFY_EMAIL)
                {
                    notifyFixed((BRANCH_NAME == "master") ? notifyMaster : notifyBranch)
                }
            }
        }
    }
}

