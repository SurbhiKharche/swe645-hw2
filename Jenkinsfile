pipeline {
	agent any
	environment {
		DOCKERHUB_PASS = credentials('docker-pass')
	}
	stages {
		stage("Building the Student Survey Image") {
			steps {
				script {
					checkout scm
					sh 'echo ${BUILD_TIMESTAMP}'
					sh 'docker login -u SurbhiKharcheJenkins -p ${DOCKERHUB_PASS}'
					def customImage = docker.build("SurbhiKharcheJenkins/studentsurveyform:${BUILD_TIMESTAMP}")
				}
			}
		}
		stage("Pushing image to Dockerhub") {
			steps {
				script {
					sh 'docker push SurbhiKharcheJenkins/studentsurveyform:${BUILD_TIMESTAMP}'
				}
			}
		}
		stage("Deploying to Rancher as single pod") {
			steps {
				sh 'kubectl set image deployment/stusurvey-pipeline stusurvey-pipeline=SurbhiKharcheJenkins/studentsurveyform:${BUILD_TIMESTAMP} -n jenkins-pipeline'
			}
		}
	}
}