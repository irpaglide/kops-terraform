export PATH=$PATH:/usr/local/bin

ZONES=$(terraform output availability_zones|sed s/,//g | paste -s -d,)
NAME=$(terraform output name_cluster)
STATE=$(terraform output state_store)
RET=1
until [ "$RET" == "0" ] ; do
kops validate cluster \
    --name ${NAME} --state ${STATE} 2>&1  > /dev/null
RET="$?"
echo -n "."
done
echo
kops validate cluster \
    --name ${NAME} --state ${STATE}
