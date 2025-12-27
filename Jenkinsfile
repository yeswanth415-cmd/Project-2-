pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'devlop',
                    url: 'https://github.com/yeswanth415-cmd/Project-2-.git'
            }
        }

        stage('Build') {
            steps {
                echo "Building from develop branch"
                sh 'echo "Build successful"'
            }
        }   
    }
}
