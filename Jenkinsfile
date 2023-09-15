pipeline {
    agent {
        label 'ubuntu'
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('terraform-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('terraform-aws-secret-access-key')
        DOCKER_REGISTRY_NAME  = "merderik/ephemeral"
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
                stage('Helm lint') {
                    steps {
                        sh "helm lint helm/ephemeral"
                    }
                }
            }

        }
        stage('Build Docker image'){
            steps {
                sh "docker build -t ${DOCKER_REGISTRY_NAME}:${env.BUILD_NUMBER} ."
                sh "docker build -t ${DOCKER_REGISTRY_NAME}:latest ."
            }
        }
        stage("Release Docker images") {
            steps {
                sh "docker push ${DOCKER_REGISTRY_NAME}:${env.BUILD_NUMBER}"
                sh "docker push ${DOCKER_REGISTRY_NAME}:latest"
            }
        }
        stage('Deploy Helm to Minikube') {
            steps {
                sh "helm upgrade --install --set image.tag=${env.BUILD_NUMBER} ephemeral helm/ephemeral"
            }
        }
    }
    post {
        always {
            sh "docker rmi ${DOCKER_REGISTRY_NAME}:${env.BUILD_NUMBER}"
            sh "docker rmi ${DOCKER_REGISTRY_NAME}:latest"
        }
    }
}