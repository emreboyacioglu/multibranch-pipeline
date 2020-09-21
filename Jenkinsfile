pipeline {

    agent {
        node {
            label 'master'
        }
    }

    options {
        buildDiscarder logRotator( 
                    daysToKeepStr: '16', 
                    numToKeepStr: '10'
            )
    }

    stages {
        
        stage('Cleanup Workspace') {
            steps {
                cleanWs()
                sh """
                echo "Cleaned Up Workspace For Project"
                """
            }
        }

        stage('Code Checkout') {
            steps {
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/develop']], 
                    userRemoteConfigs: [[url: 'https://github.com/emreboyacioglu/multibranch-pipeline.git']]
                ])
            }
        }

        stage(' Unit Testing') {
            steps {
                sh """
                echo "Running Unit Tests"
                """
            }
        }

        stage('Code Analysis') {
            steps {
                sh """
                echo "Running Code Analysis"
                """
            }
        }
	stage('Feature Deployment') {
            when{
		branch 'feature'
	    }
	    steps {
                sh """
                echo "Feature Deployment!! Hey!"
                """
            }
        }
        stage('Build Deploy Code') {
	    git credentialsId: 'c559df4a-0b8b-41f1-8cba-d963785da2fe', url: 'https://github.com/emreboyacioglu/multibranch-pipeline.git'
            when {
                branch 'develop'
            }
            steps {
                sh """
                echo "Building Artifact"
                """

		sh """
                cd /usr/src/multibranch-pipeline
		git fetch
		git rebase origin/master
		dotnet --version
                """

                sh """
                echo "Deploying Code"
                """
            }
        }

    }   
}
