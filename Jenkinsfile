pipeline {
    agent {
        label 'ubuntu'
    } 
    stages {
        stage('Check prerequisites') {
            steps {
                sh "python --version"
            }
        }
    }
}