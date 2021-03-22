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

KUBECONFIG=${OKD_HOME}/auth/kubeconfig oc get csr | grep -i pending



function modify_default() {
sed -i "s/default\s.*/default ${1}/" /var/lib/tftpboot/pxelinux.cfg/default
}

modify_default ${WORKER1_HOSTNAME}
echo "Please Install \"${WORKER1_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
while [ "$(ssh core@${WORKER1_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${WORKER1_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
echo -e "\n${WORKER1_HOSTNAME}.${ClusterName}.${DomainName} Installed !"

modify_default ${WORKER2_HOSTNAME}
echo "Please Install \"${WORKER2_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
while [ "$(ssh core@${WORKER2_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${WORKER2_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
echo -e "\n${WORKER2_HOSTNAME}.${ClusterName}.${DomainName} Installed !"
