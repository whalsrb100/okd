#!/bin/bash
source src/env
default_cnt=0
################################################
# /var/lib/tftpboot/pxelinux.cfg/default
################################################
# 0 : bootstrap
# 1 : master1
# 2 : master2
# 3 : master3
# 4 : worker1
# 5 : worker2
# 6 : worker3
# 7 : worker4
################################################

function default_count_add() {
default_cnt=$(expr ${default_cnt} \+ 1)
sed -i "s/prompt\s./prompt ${default_cnt}/" /var/lib/tftpboot/pxelinux.cfg/default
}

default_cnt=4
sed -i "s/prompt\s./prompt ${default_cnt}/" /var/lib/tftpboot/pxelinux.cfg/default
echo "Please Install \"${WORKER1_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
while [ "$(ssh core@${WORKER1_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${WORKER1_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
echo -e "\n${WORKER1_HOSTNAME}.${ClusterName}.${DomainName} Installed !"
default_count_add

echo "Please Install \"${WORKER2_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
while [ "$(ssh core@${WORKER2_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${WORKER2_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
echo -e "\n${WORKER2_HOSTNAME}.${ClusterName}.${DomainName} Installed !"
default_count_add

#echo "Please Install \"${WORKER3_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
#while [ "$(ssh core@${WORKER3_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${WORKER3_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
#echo -e "\n${WORKER3_HOSTNAME}.${ClusterName}.${DomainName} Installed !"

echo -ne "\nExecute Command: openshift-install wait-for install-complete --dir=${OKD_HOME} --log-level debug"
for i in $(seq 1 3);do echo -n '.';done && echo
openshift-install wait-for install-complete --dir=${OKD_HOME} --log-level debug
