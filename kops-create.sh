#!/bin/bash
export PATH=$PATH:/usr/local/bin

ZONES=$(terraform output availability_zones|sed s/,//g | paste -s -d,)
NAME=$(terraform output name_cluster)
PRIVATE_SUBNETS=$(terraform output private_subnet_ids|sed s/,//g|paste -s -d,)
PUBLIC_SUBNETS=$(terraform output public_subnet_ids|sed s/,//g|paste -s -d,)
ssh-keygen -b 2048 -t rsa -f ~/.ssh/id_rsa_kops -q -N ""

kops get cluster ${NAME} --state $(terraform output state_store)


if [ "$?" == "0" ]; then
   kops update cluster ${NAME} \
   --ssh-public-key ~/.ssh/id_rsa.pub \
   --target=terraform \
   --out=. \
   --state=$(terraform output state_store)
  echo "CLUSTER EXISTS"
  exit 0
else
  kops create cluster \
      --ssh-public-key ~/.ssh/id_rsa.pub \
      --master-zones $ZONES \
      --zones $ZONES \
      --topology private \
      --dns-zone $(terraform output public_zone_id) \
      --networking calico \
      --target=terraform \
      --vpc $(terraform output vpc_id) \
      --utility-subnets $PUBLIC_SUBNETS \
      --subnets $PRIVATE_SUBNETS \
      --state $(terraform output state_store) \
      --out=. \
      --name ${NAME}


fi
