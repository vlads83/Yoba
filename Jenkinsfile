#!/usr/bin/env groovy

import jenkins.model.Jenkins
import hudson.model.*
import groovy.json.*

node('master'){

 //clean up work space
    step([$class: 'WsCleanup'])

    env.GIT_REPO_URL = 'https://github.com/vlads83/Yoba.git'
    echo "Detected Git Repo URL: ${env.GIT_REPO_URL} , branch : ${env.BRANCH_NAME} , committer : ${env.GIT_AUTHOR_EMAIL}"

    checkout([$class: 'GitSCM', branches: [[name: '*/${env.BRANCH_NAME}']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'UserExclusion', excludedUsers: '''narezatel''']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '8cc10957-0d45-44f5-88e6-c3c2633213b9', url: 'https://github.com/vlads83/Yoba.git']]])

    //git url: "${env.GIT_REPO_URL}", credentialsId:'c8c4793d-47e6-47ba-95a5-d7810ed9d906', branch: "${env.BRANCH_NAME}";
    ////
     git_msg = sh (script: "git log -1 | grep 'DRY_RUN'", returnStatus: true)
     echo "GIT message : ${git_msg}"

    

 //set additional variables    
    env.NODEJS_SRC_PATH = "src/node-docker/"
 // print variables
    sh ("printenv")

////// Job stages //////////

	stage ("Git"){
	 git url: "${env.GIT_REPO_URL}", credentialsId:'87d758d1-7a6c-4343-829c-0ce14ccf6474', branch: "${env.BRANCH_NAME}";	
	} //end of stage
	
	stage ('Build'){
	 sh ("chmod u+x ci_tools/build.sh")
	 sh ("ci_tools/build.sh")
	} //end of stage
	
////////////////////////////

} //end of node 
