terraform plan -out init.plan 
terraform apply init.plan
./kops-create.sh
terraform plan -out kops.plan
terraform apply kops.plan
