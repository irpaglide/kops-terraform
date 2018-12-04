pipeline {
    agent any

    parameters {
        credentials(name: 'AWS_KEY_ID', description: 'AWS KEYS CREDENTIALS ID', defaultValue: 'aws-jmgarciatest', credentialType: "Username with password", required: true )
    }

    stages {
        stage("Create Initial Infrastructure") {
            steps {
              withCredentials([[$class: 'UsernamePassword', credentialsId: "${params.AWS_KEY_ID}", usernameVariable: 'PUBLIC_KEY', passwordVariable: 'PRIVATE_KEY']])
                        {
                            sh '''
                              export AWS_ACCESS_KEY_ID=${PUBLIC_KEY}
                              export AWS_SECRET_ACCESS_KEY=${PRIVATE_KEY}
                              pterrafile
                            '''
                        }

            }
        }
    }
}
