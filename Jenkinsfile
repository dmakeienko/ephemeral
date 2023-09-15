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
        stage('Lint and format') {
            parallel {
                stage('Terraform validate and format') {
                    sh "echo $PWD"
                    sh "cd infra/$JOB_NAME" && tfenv use && terraform init && terraform format && terraform validate
                }
                stage('Python lint') {
                    sh "pylint app/main.py"
                }
            }

        }
    }
}