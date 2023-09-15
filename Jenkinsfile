pipeline {
    agent {
        label 'ubuntu'
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('terraform-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('terraform-aws-secret-access-key')
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
                    sh """cd infra/$JOB_NAME"  \
                    && tfenv use \
                    && terraform init \
                    && terraform format \
                    && terraform validate"""
                }
                stage('Python lint') {
                    sh "pylint app/main.py"
                }
            }

        }
    }
}