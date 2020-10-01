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
        stage('Code Checkout Feature') {
           when{
               branch 'feature'
           }
                steps {
                    sh """ 
                    cd /usr/src/multibranch-pipeline-feature
                    git checkout feature
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
                    git checkout  develop
                    git status
                    git fetch --all  
                    git reset --hard origin/develop
                    """
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
        stage('Test') {
            steps {
                sh """
                dotnet test
                """
            }
        }
    }
}   

