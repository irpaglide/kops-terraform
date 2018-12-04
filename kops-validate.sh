export PATH=$PATH:/usr/local/bin

ZONES=$(terraform output availability_zones|sed s/,//g | paste -s -d,)
NAME=$(terraform output name_cluster)
kops validate cluster \
    --name ${NAME} --state $(terraform output state_store) 
