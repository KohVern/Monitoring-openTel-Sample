pipeline {
    agent any

    stages {
        stage ("Checkout") {
            steps {
                git branch: 'main', url: 'https://github.com/KohVern/Monitoring-openTel-Sample'
            }
        }

        stage ("Build") {
            steps {
                echo 'Building the project...'
            }
        }

        stage ("Test") {
            steps {
                echo 'Running tests...'
            }
        }

        stage ("Deploy") {
            steps {
                echo 'Deploying the application...'
            }
        }
    }

    post {
        always {
            echo 'This will always run after the pipeline completes.'
        }
        success {
            echo 'This will run only if the pipeline is successful.'
        }
        failure {
            echo 'This will run only if the pipeline fails.'
        }
    }
}