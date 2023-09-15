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
                    steps {
                    sh """cd infra/${env.JOB_NAME}  \\
                        && tfenv use \\
                        && terraform init \\
                        && terraform validate"""
                    }
                }
                stage('Python lint') {
                    steps {
                        sh "pylint app/main.py"
                    }
                }
            }

        }
        stage('Build Docker image'){
            steps {
                sh "docker build -t ${env.JOBNAME}:${env.BUILD_NUMBER} ."
                sh "docker build -t ${env.JOBNAME}:latest ."
            }
        }
        stage("Release Docker images") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-registry', passwordVariable: 'docker-registry-password', usernameVariable: 'docker-registry-user')]) {
                    sh "docker login --username ${docker-registry-user} --password ${docker-registry-password}"
                    sh "docker push ${env.JOBNAME}:${env.BUILD_NUMBER}"
                    sh "docker push ${env.JOBNAME}:latest"
                }
            }
        }
    }
}