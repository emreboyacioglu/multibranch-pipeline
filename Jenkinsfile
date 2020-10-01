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
        stage('Code Checkout') {
            if(env.BRANCH_NAME == 'feature')
            {
                steps {
                    sh """ 
                    git checkout feature
                    git status
                    git fetch --all  
                    git reset --hard origin/feature
                    """
                }
            }
            else if(env.BRANCH_NAME == 'develop')
            {
                steps {
                    sh """ 
                    git checkout develop
                    git status
                    git fetch --all  
                    git reset --hard origin/develop
                    """
                }
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

