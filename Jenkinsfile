#!/usr/bin/env groovy

import jenkins.model.Jenkins
import hudson.model.*
import groovy.json.*
node('master'){
    //clean up work space
    step([$class: 'WsCleanup'])
    env.GIT_REPO_URL = 'https://github.com/vlads83/LabeanRepo.git'
    echo "Detected Git Repo URL: ${env.GIT_REPO_URL} , branch : ${env.BRANCH_NAME} , committer : ${env.GIT_AUTHOR_EMAIL}"
      sh ("printenv")
}
