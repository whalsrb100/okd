#!/bin/bash
source src/env
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
sed -i "s/prompt\s.*/prompt ${1}/" /var/lib/tftpboot/pxelinux.cfg/default
}

default_count_add ${WORKER1_HOSTNAME}
echo "Please Install \"${WORKER1_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
while [ "$(ssh core@${WORKER1_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${WORKER1_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
echo -e "\n${WORKER1_HOSTNAME}.${ClusterName}.${DomainName} Installed !"

default_count_add ${WORKER2_HOSTNAME}
echo "Please Install \"${WORKER2_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
while [ "$(ssh core@${WORKER2_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${WORKER2_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
echo -e "\n${WORKER2_HOSTNAME}.${ClusterName}.${DomainName} Installed !"
