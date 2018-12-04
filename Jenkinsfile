pipeline {
    agent any

    parameters {
        credentials(name: 'AWS_KEY_ID', description: 'AWS KEYS CREDENTIALS ID', defaultValue: 'jmgarciatest', credentialType: "Username with password", required: true )
        choice(
            choices: ['verify','create','destroy'],
            description: '',
            name: 'REQUESTED_ACTION')
        string(name: 'NOTIFY_TO',description: '',defaultValue: 'jmgarcia@irpaglide.com')

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
                sleep 15
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
                sleep 30
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
                  sleep 20
                  sh '/usr/local/bin/terraform destroy --auto-approve'
                }
              }
            }
        }
        stage("Verify cluster") {
          when {
                expression { params.REQUESTED_ACTION == 'verify' }
              }
            steps {
              withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "${params.AWS_KEY_ID}"]]) {
                ansiColor('xterm') {
                  sh './kops-validate.sh'
                }
              }
            }
        }
    }
    post {
      always {
          deleteDir() /* clean up our workspace */
      }
      success {
        script {
          when {
                expression { params.REQUESTED_ACTION == 'verify' }
              }
          emailext (
            subject: "YOUR CLUSTER IS READY",
            from: "jenkins-no-reply@irpaglide.com",
            to: "${params.NOTIFY_TO}",
            body: "Link to build: ${BUILD_URL}"
          )
        }
      }
    }
}
