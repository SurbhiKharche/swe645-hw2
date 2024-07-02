pipeline {
	agent any
	environment {
		DOCKERHUB_PASS = credentials('docker-pass')
		BUILD_TIMESTAMP = new Date().format("yyyyMMdd-HHmmss", TimeZone.getTimeZone("UTC"))
	}
	stages {
		stage("Building the Student Survey Image") {
			steps {
				script {
					checkout scm
					sh 'echo ${BUILD_TIMESTAMP}'
					sh 'docker login -u surbhikharche -p ${DOCKERHUB_PASS_PSW}'
					def customImage = docker.build("surbhikharche/hw2-docker-image:${BUILD_TIMESTAMP}")
				}
			}
		}
		stage("Pushing image to Dockerhub") {
			steps {
				script {
					sh 'docker push surbhikharche/hw2-docker-image:${BUILD_TIMESTAMP}'
				}
			}
		}
		stage("Deploying to Rancher as single pod") {
			steps {
				sh 'kubectl set image deployment/stusurvey-pipeline stusurvey-pipeline=surbhikharche/hw2-docker-image:${BUILD_TIMESTAMP} -n jenkins-pipeline'
			}
		}
	}
}