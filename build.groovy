#!/usr/bin/env groovy

import jenkins.model.Jenkins
import hudson.model.*
import groovy.json.*

node('master'){
	
try {
 //clean up work space
    step([$class: 'WsCleanup'])
	
BRANCH_NAME='master'
	
	checkout([$class: 'GitSCM',
	  branches: [[name: "*/${env.BRANCH_NAME}"]],
	  doGenerateSubmoduleConfigurations: false,
	  submoduleCfg: [],
	  userRemoteConfigs: [[credentialsId: '8cc10957-0d45-44f5-88e6-c3c2633213b96',
	  url: "${env.GIT_REPO_URL}"]]])
    
    //insert build paramerts into envs_properties
	if ("${env.BRANCH_NAME}" =~ /.*HOTFIX.*/) {
        sh("""sed -ri "s/(GITSCM_POLLING=)[^=]*\$/\\1\\"disable\\"/" ${envPropertiesPath}""")
      } //end if
	
	if ("${git_msg}" == '0') {
	echo "Modifying pipiline"
        sh("""sed -ri "s/(GITSCM_POLLING=)[^=]*\$/\\1\\"disable\\"/" ${envPropertiesPath}""")
      } //end if
      
      echo "Cat pipiline_properties , 2nd time"
      sh("cat ci_tools/pipeline_properties")

      load 'ci_tools/pipeline_properties'
      sh("printenv")


   //configure job properties
     properties([
              parameters([
                 string(name: 'SERVICE_NAME', defaultValue: "${env.SERVICE_NAME}", description: 'Service name'),
                  //string(name: 'ENVIRONMENT_TYPE', defaultValue: "${env.ENVIRONMENT_TYPE}", description: 'Environment name'),
                  //choice(choices: ['integration', 'staging', 'production'].join("\n"), description: 'Environment name', name: 'ENVIRONMENT_TYPE'),
                  //string(name: 'PLATFORM_NAME', defaultValue: "${env.PLATFORM_NAME}", description: 'Platform name'),
                ]),
                [$class: 'jenkins.model.BuildDiscarderProperty', strategy: [$class: 'LogRotator', numToKeepStr: '50']],
                disableConcurrentBuilds(),
                ])
       
         
}//end of try

catch(err){
    throw err
    error "Colud not find any Git repository for the job ${JOB_NAME}"
} //end of catch

} //end of node

node('master'){

try {

stage ('Build'){
	 sh ("chmod u+x ci_tools/build.sh")
	 sh ("ci_tools/build.sh")
	} //end of stage
	
////////////////////////////
 } //end of try

	catch(err){
    	throw err
    	error "Error in job ${JOB_NAME}"
	} //end of catch

} //end of node 
