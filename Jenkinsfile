pipeline {
    agent any

    parameters {
        credentials(name: 'AWS_KEY_ID', description: 'AWS KEYS CREDENTIALS ID', defaultValue: 'aws-jmgarciatest', credentialType: "Username with password", required: true )
    }

    stages {
        stage("foo") {
            steps {
                echo "flag: ${params.AWS_KEY_ID}"
            }
        }
    }
}
