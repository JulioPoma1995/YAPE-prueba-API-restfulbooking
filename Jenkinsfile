pipeline {
    agent { label 'any' }
   tools {
        git 'GitGlobal'
    }
    stages {
        stage('Checkout SCM') {
            steps {
                script {
                    checkout scm
                }
            }
        }
        stage('Install Dependencies') {
            steps {
                script {
                    sh 'mvn install'
                }
            }
        }
        stage('Run API Tests') {
            steps {
                script {
                    sh 'mvn test -Dkarate.options="--tags @auth"'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished!'
        }
        success {
            echo 'Pipeline finished successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}