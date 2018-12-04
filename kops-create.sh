#!/bin/bash
export PATH=$PATH:/usr/local/bin

ZONES=$(terraform output availability_zones|sed s/,//g | paste -s -d,)
NAME=$(terraform output name_cluster)
PRIVATE_SUBNETS=$(terraform output private_subnet_ids|sed s/,//g|paste -s -d,)
PUBLIC_SUBNETS=$(terraform output public_subnet_ids|sed s/,//g|paste -s -d,)

kops get cluster ${NAME} --state $(terraform output state_store)
if [ "$?" == "0" ]; then
   kops update cluster ${NAME} --yes --state=$(terraform output state_store)
  echo "CLUSTER ALREADY DEFINED"
  exit 0
else
  ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa_kops -q -N ""

  kops create secret \
  --state $(terraform output state_store) \
  --name ${NAME} \
  sshpublickey admin -i ~/.ssh/id_rsa_kops.pub

  kops create cluster \
      --master-zones $ZONES \
      --zones $ZONES \
      --topology private \
      --dns-zone $(terraform output public_zone_id) \
      --networking calico \
      --vpc $(terraform output vpc_id) \
      --utility-subnets $PUBLIC_SUBNETS \
      --subnets $PRIVATE_SUBNETS \
      --state $(terraform output state_store) \
      --out=. \
      ${NAME}
fi
