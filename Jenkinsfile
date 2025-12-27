pipeline {
    agent any

    environment {
        IMAGE = "yeswanth415/demo-app"
        DOCKERHUB_CREDS = "dockerhub-creds"  // Jenkins credentials ID
        KUBE_NAMESPACE = "default"           // Change if needed
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Cloning repository..."
                git branch: 'main',
                    url: 'https://github.com/yeswanth415-cmd/Project-2-.git'
            }
        }

        stage('Verify Tools') {
            steps {
                echo "Checking Docker version..."
                sh 'docker --version || echo "Docker not found!"'
                echo "Checking kubectl version..."
                sh 'kubectl version --client || echo "kubectl not found!"'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t $IMAGE:latest .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                echo "Logging in to DockerHub..."
                withCredentials([usernamePassword(
                    credentialsId: DOCKERHUB_CREDS,
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Pushing image to DockerHub..."
                sh 'docker push $IMAGE:latest'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "Applying Kubernetes manifests..."
                sh """
                    kubectl apply -f deployment.yaml -n $KUBE_NAMESPACE
                    kubectl apply -f service.yaml -n $KUBE_NAMESPACE
                    kubectl rollout status deployment/demo-app -n $KUBE_NAMESPACE
                """
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed. Check logs for errors."
        }
    }
}
