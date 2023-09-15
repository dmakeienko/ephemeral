pipeline {
    agent {
        label 'ubuntu'
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('terraform-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('terraform-aws-secret-access-key')
        DOCKER_REGISTRY_NAME  = "merderik/ephemeral"
        TF_VAR_db_password    = credentials('TF_VAR_db_password')
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
        stage("Create/Update Infra") {
            steps {
                 sh """cd infra/${env.JOB_NAME}  \\
                        && tfenv use \\
                        && terraform init \\
                        && terraform apply -auto-approve"""                
            }
        }
        stage('Build Docker image'){
            steps {
                sh "docker build -t ${DOCKER_REGISTRY_NAME}:${env.BUILD_NUMBER} -t ${DOCKER_REGISTRY_NAME}:latest ."
            }
        }
        stage("Release Docker images") {
            steps {
                sh "docker image push --all-tags ${DOCKER_REGISTRY_NAME}"
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
            sh "docker rmi --force ${DOCKER_REGISTRY_NAME}:${env.BUILD_NUMBER} ${DOCKER_REGISTRY_NAME}:latest"
        }
    }
}