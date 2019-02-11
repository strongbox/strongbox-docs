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
        PUBLISH_URL="https://strongbox.github.io"
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
                sh "git checkout --orphan gh-pages"
                sh "git rm -rf !(site) ."
                sh "git add --force site/ && git commit -m 'Updating documentation site.'"
                sh "git remote add strongbox.github.io git@github.com:strongbox/strongbox.github.io.git"
                sh "git push strongbox.github.io `git subtree split --prefix site gh-pages`:master --force"
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
