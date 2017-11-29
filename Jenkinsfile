#!/usr/bin/env groovy
import jenkins.model.Jenkins
import hudson.model.*
import groovy.json.*

node('master'){
	
  try{    // Get pipeline_properties file from GitHub and set required evvironment variables and job properties. 
          // In case of falure , catch actions will be executed and then job will be terminated with "FALURE" status.
	  
    // Clean up work space	  
    step([$class: 'WsCleanup'])
    
    // Building GitHub repository URL 
    def split = "${JOB_NAME}".split('/')
    env.GIT_REPO_NAME = split[1]
    env.GIT_OWNER = split[0]
    env.GIT_REPO_URL = 'https://github.com/vlads86/' + "${env.GIT_REPO_NAME}" + '.git'
    echo "Detected Git Repo URL: ${env.GIT_REPO_URL} , branch : ${env.BRANCH_NAME}"

    //Checkout GitHub , download pipeline_properties file
    checkout([$class: 'GitSCM',
	  branches: [[name: "*/${env.BRANCH_NAME}"]],
	  doGenerateSubmoduleConfigurations: false,
	  extensions: [[$class: 'SparseCheckoutPaths', sparseCheckoutPaths: [[path: 'ci_tools/pipeline_properties']]]],
	  submoduleCfg: [],
	  userRemoteConfigs: [[credentialsId: '8cc10957-0d45-44f5-88e6-c3c2633213b9',
	  url: "${env.GIT_REPO_URL}"]]])
    
 
////// detect "ci skip" message /////	
    git_msg = sh (script: "git log -1 | egrep 'ci_skip|CI_SKIP|UT-Israel-DevOps'", returnStatus: true)
    echo "GIT message : ${git_msg}"
 
    if ("${git_msg}" == '0') {
      echo "CI_SKIP message or self-commit detected , aborting job" 
      currentBuild.result = 'ABORTED'
      return    
    }	//end if  


///// set parameters
stage ('Parameters') {
 properties([
              parameters([
                  string(name: 'SERVICE_NAME', defaultValue: "${env.SERVICE_NAME}", description: 'Service name'),
                  string(name: 'ENVIRONMENT_TYPE', defaultValue: "${env.ENVIRONMENT_TYPE}", description: 'Environment name'),
              ]), //end parametrs
              [$class: 'jenkins.model.BuildDiscarderProperty', 
	            strategy: [$class: 'LogRotator', numToKeepStr: '50']
	      ], //end class
        disableConcurrentBuilds(),
	pipelineTriggers([githubPush()]),
	    ]) //end properties
    } //end stage
	  

  } //end of try
	
catch(error){
     currentBuild.result = 'FALURE'
}	
finaly {}
} //end of node
	
