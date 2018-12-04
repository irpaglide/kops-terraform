# Kubernetes Cluster Deployment
## Deployed in  AWS Multi-AZ with terraform + kops

### Technology used:
* Kubernetes
* Terraform
* Jenkins

#### Pre-requisites:

##### System Packages:

* kubectl
* terraform
* kops
* git

##### Jenkins plugins:

 - docker
 - aws credentials
 - ansiColor
 - pipeline
 - git


### Instructions:



### To Deploy Automatically:

* There is a Declarative Jenkinsfile Pipeline that you can use in your jenkins server.

#### Dependencies in the Jenkinsfile:

##### System Packages:

* kubectl
* terraform
* kops
* git

##### Jenkins plugins:

 - docker
 - aws credentials
 - ansiColor
 - pipeline
 - git

After installing the plugins, upload your AWS Credentials to Jenkins credentials as type: "AmazonWebServicesCredentialsBinding"

Modify the parameters defaults for this field if needed.

Modify the pollSCM interval if you want to.

This job has a parameter "REQUESTED_ACTION" with choices:
choices: ['verify','create','destroy']

For creating the cluster:
  1) run with "create"
  Since it takes quite while to create the cluster, I suggest to:
  2) run it afterwards with "verify". It will ask you for an email and spin until it's done, and will let you know by email.

For destroy the cluster:
  Just run it with "Destroy"
