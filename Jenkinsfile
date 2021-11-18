pipeline {
	agent any

	environment {
		PROJECT = 'insecure-bank'
	}

	tools {
		jdk 'openjdk-11'
	}

	stages {
        stage('clean') {
            cleanWs()
        }
		stage('Build') {
			steps {
				sh 'mvn -B compile'
			}
		}
    }
