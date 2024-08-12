pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'DOCKERHUB'
        GITHUB_CREDENTIALS_ID = 'GITHUB'
    }

    stages {
        stage('Checkout') {
            steps {
                // Explicitly checkout from GitHub
                checkout([$class: 'GitSCM',
                          userRemoteConfigs: [[url: 'https://github.com/bincysjames/cicd-pipeline-train-schedule-autodeploy.git',
                                               credentialsId: env.GITHUB_CREDENTIALS_ID]],
                          branches: [[name: '*/master']]])  // Adjust the branch name if needed
            }
        }
        stage(' Docker Image build') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'docker build -t bincyjames/abstergo-corp/website:latest .'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: env.DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                        sh 'docker push bincyjames/abstergo-corp/website:latest'
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Replace 'your-deployment' with the name of your Kubernetes deployment
                    //sh 'kubectl set image deployment/your-deployment-name your-container=bincyjames/your-image-name:latest'
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
    }
}
