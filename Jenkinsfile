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
                checkout([
                    $class: 'GitSCM', 
                    branches: [[name: '*/master']], 
                    userRemoteConfigs: [[url: 'https://github.com/emreboyacioglu/multibranch-pipeline.git']]
                ])
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

