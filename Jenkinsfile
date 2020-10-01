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
        stage('Git SCM') {
            steps {
                checkout scm
            }
        }
        stage('Build CI Artifacts') {
            steps {
                sh """
                dotnet restore
                dotnet clean
                dotnet build --configuration Release 
                """
            }
        }
        stage('Unit Testing') {
            steps {
                sh """
                dotnet test --logger:"trx;logFileName=report.xml" 
                """
            }
        }
        stage('Code Checkout Feature') {
           when{
               branch 'feature'
           }
                steps {
                    sh """    
                    cd /usr/src/multibranch-pipeline-feature                    
                    git stash
                    git stash clear
                    git status
                    git pull
                    """
                }
            
        }
        
        stage('Code Checkout Develop'){
            when{
                branch 'develop'
            }
             steps {
                    sh """ 
                    cd /usr/src/multibranch-pipeline-develop
                    git stash
                    git stash clear
                    git status
                    git pull
                    """
                }
        }
        
    }
}   

