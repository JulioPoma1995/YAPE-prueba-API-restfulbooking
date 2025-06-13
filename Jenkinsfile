pipeline {
    agent { label 'principal' }

    environment {
        MAVEN_HOME = tool 'Maven'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/JulioPoma1995/YAPE-prueba-API-restfulbooking.git'
            }
        }

        stage('Build') {
            steps {
                sh "${MAVEN_HOME}/bin/mvn clean install"
            }
        }

        stage('Run Tests') {
            steps {
                sh "${MAVEN_HOME}/bin/mvn test -Dcucumber.filter.tags='@healthcheckPing'"
            }
        }
    }

    post {
        always {
             node(label: 'principal') {
                     junit '**/target/surefire-reports/*.xml'
                   }
        }
    }
}