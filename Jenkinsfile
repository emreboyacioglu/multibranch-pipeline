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
                    branches: [[name: '*/master']], 
                    userRemoteConfigs: [[url: 'https://github.com/emreboyacioglu/multibranch-pipeline.git']]
                ])
            }
        }

        stage('Code Analysis') {
            steps {
                sh """
                echo "Running Code Analysis"
                """
            }
        }
	stage('Feature CI') {
            when{
		branch 'feature'
	    }
	    steps {
                sh """
                echo "Building Artifact!"

                cd /usr/src/multibranch-pipeline-feature
		git pull	
		

                """


            }
	    post{
                success {
                     sh """ 
			echo "Feature Build & Deploy tamamlandı."
			"""
                }
            }
        }
	stage('Master CI') {
            when{
		branch 'master'
	    }
	    steps {
                sh """
                echo "Building Artifact"

                cd /usr/src/multibranch-pipeline
		git pull		
		

                """

            }
	    post{
                success {
                     sh """ 
			echo "Master Build & Deploy tamamlandı."
			"""
                }
            }

        }
        stage('Develop CI/CD') {
            when {
                branch 'develop'
            }
            steps {
                sh """
                echo "Building Artifact  "

                cd /usr/src/multibranch-pipeline-develop
		git pull
		docker build -t devops-demo-develop .
		docker run -it --rm -p 5001:80 --name devops-demo-develop devops-demo
		
		
                """
            }
	    post{
                success {
                     sh """ 
			echo "Develop Build & Deploy tamamlandı."					"""
                }
            }
        }

    }   
}
