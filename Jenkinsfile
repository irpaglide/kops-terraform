pipeline {
    agent any

    parameters {
        credentials(name: 'AWS_KEY_ID', description: 'AWS KEYS CREDENTIALS ID', defaultValue: 'jmgarciatest', credentialType: "Username with password", required: true )
    }

    stages {
        stage("Create Initial Infrastructure") {
            steps {
                sh 'pterrafile'
            }
            steps {
              withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${params.AWS_KEY_ID}"]]) {
                sh 'terraform init'
              }
            }
        }
    }
}
