pipeline {
    agent {
        label 'ubuntu'
    } 
    stages {
        stage('Check prerequisites') {
            steps {
                sh "python3 --version"
                sh "tfenv version-name"
                sh "docker -v"
            }
        }
    }
}