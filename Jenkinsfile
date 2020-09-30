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
                sh """
                git gc
                git reset --hard
                git pull
                """
            }
        }

        stage('Build CI') {
            steps {
                sh """
                dotnet restore
                dotnet clean
                dotnet build --configuration Release
                """
            }post{
                success {
                    sh """ 
                    echo "Develop Build & Deploy tamamlandı."					
                    """
                }
                failure {
                    echo "THERE IS A PROBLEM IN BUILD!"
                }
            }
        }
        stage('Test) {
            steps {
                sh """
                dotnet test
                """
            }
        }
        
            
        }
    }   
}
