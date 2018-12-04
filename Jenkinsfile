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
                ansiColor('xterm') {
                  sh '/usr/local/bin/terraform init'
                }
              }
            }
        }
        stage("Create Initial infrastructure") {
            steps {
              withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${params.AWS_KEY_ID}"]]) {
                ansiColor('xterm') {
                  sh '/usr/local/bin/terraform plan -out initial.plan'
                  sh '/usr/local/bin/terraform apply initial.plan'
                }
              }
            }
        }
        stage("KOPS Cluster Definition") {
            steps {
              withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${params.AWS_KEY_ID}"]]) {
                sh './kops-create.sh'
              }
            }
        }
        stage("Deploy kops cluster") {
            steps {
              withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${params.AWS_KEY_ID}"]]) {
                ansiColor('xterm') {
                  sh '/usr/local/bin/terraform plan -out kops.plan'
                  sh '/usr/local/bin/terraform apply kops.plan'
                }
              }
            }
        }
    }
}
