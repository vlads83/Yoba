#!/usr/bin/env groovy

import jenkins.model.Jenkins
import hudson.model.*
import groovy.json.*

node('master'){

 //clean up work space
    step([$class: 'WsCleanup'])

    env.GIT_REPO_URL = 'https://github.com/vlads83/Yoba.git'
    echo "Detected Git Repo URL: ${env.GIT_REPO_URL} , branch : ${env.BRANCH_NAME} , committer : ${env.GIT_AUTHOR_EMAIL}"

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
