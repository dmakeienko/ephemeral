pipeline {
    agent {
        label 'ubuntu'
        label 'docker'
    } 
    stages {
        stage('Check prerequisites') {
            steps {
                sh "python --version"
            }
        }
    }
}