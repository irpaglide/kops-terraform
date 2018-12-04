pipeline {
    agent any

    parameters {
        credentials(name: 'AWS_KEY_ID', description: 'AWS KEYS CREDENTIALS ID', defaultValue: 'jmgarciatest', credentialType: "Username with password", required: true )
    }

    stages {
        stage("Get Terraform Modules") {
            steps {
                sh 'pterrafile'
            }
        }
        stage("Initialize terraform") {
            steps {
              withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${params.AWS_KEY_ID}"]]) {
                sh 'terraform init'
              }
            }
        }
    }
}
