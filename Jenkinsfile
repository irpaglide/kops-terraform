pipeline {
    agent any

    parameters {
        credentials(name: 'AWS_KEY_ID', description: 'AWS KEYS CREDENTIALS ID', defaultValue: 'jmgarciatest', credentialType: "Username with password", required: true ),
        choice(
            choices: ['create' , 'destroy'],
            description: '',
            name: 'REQUESTED_ACTION')
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
          when {
                expression { params.REQUESTED_ACTION == 'create' }
              }
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
          when {
                expression { params.REQUESTED_ACTION == 'create' }
              }
            steps {
              withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${params.AWS_KEY_ID}"]]) {
                sh './kops-create.sh'
              }
            }
        }
        stage("Deploy kops cluster") {
          when {
                expression { params.REQUESTED_ACTION == 'create' }
              }

            steps {
              withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${params.AWS_KEY_ID}"]]) {
                ansiColor('xterm') {
                  sh '/usr/local/bin/terraform plan -out kops.plan'
                  sh '/usr/local/bin/terraform apply kops.plan'
                }
              }
            }
        }
        stage("Destroy cluster") {
          when {
                expression { params.REQUESTED_ACTION == 'destroy' }
              }
            steps {
              withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${params.AWS_KEY_ID}"]]) {
                ansiColor('xterm') {
                  sh './kops-delete.sh --yes'
                  sh '/usr/local/bin/terraform destroy --auto-approve'
                }
              }
            }
        }
    }
}
