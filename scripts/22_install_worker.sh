#!/bin/bash
source src/env

echo "Please Install \"${WORKER1_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
while [ "$(ssh core@${WORKER1_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${WORKER1_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
echo -e "\n${WORKER1_HOSTNAME}.${ClusterName}.${DomainName} Installed !"

echo "Please Install \"${WORKER2_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
while [ "$(ssh core@${WORKER2_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${WORKER2_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
echo -e "\n${WORKER2_HOSTNAME}.${ClusterName}.${DomainName} Installed !"

echo "Please Install \"${WORKER3_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
while [ "$(ssh core@${WORKER3_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${WORKER3_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
echo -e "\n${WORKER3_HOSTNAME}.${ClusterName}.${DomainName} Installed !"

echo -ne "\nExecute Command: openshift-install wait-for install-complete --dir=${OKD_HOME} --log-level debug"
for i in $(seq 1 3);do echo -n '.';done && echo
openshift-install wait-for install-complete --dir=${OKD_HOME} --log-level debug
