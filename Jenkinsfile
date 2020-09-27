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
	stage('Feature Build&Deploy') {
            when{
		branch 'feature'
	    }
	    steps {
                sh """
                echo "Building Artifact"

                cd /usr/src/multibranch-pipeline-feature
		
		dotnet clean
		dotnet restore
		dotnet publish
		dotnet --version

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
	stage('Master Build&Deploy') {
            when{
		branch 'master'
	    }
	    steps {
                sh """
                echo "Building Artifact"

                cd /usr/src/multibranch-pipeline
		
		dotnet clean
		dotnet restore
		dotnet publish
		dotnet --version

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
        stage('Develop Build&Deploy') {
            when {
                branch 'develop'
            }
            steps {
                sh """
                echo "Building Artifact"

                cd /usr/src/multibranch-pipeline-develop
		
		dotnet clean
		dotnet restore
		dotnet publish
		dotnet --version
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
