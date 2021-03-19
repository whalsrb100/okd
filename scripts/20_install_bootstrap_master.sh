#!/bin/bash
source src/env

echo "Please Install \"${BOOTSTRAP_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
while [ "$(ssh core@${BOOTSTRAP_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${BOOTSTRAP_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
echo -e "\n${BOOTSTRAP_HOSTNAME}.${ClusterName}.${DomainName} Installed !"
echo -ne "Wait for bootstrap health check"
while [ $(ssh core@${BOOTSTRAP_HOSTNAME}.${ClusterName}.${DomainName} "journalctl -b | grep 'healthy: successfully committed proposal'" 2> /dev/null | wc -l) -ne 1 ];do sleep 5;echo -n ".";done

echo -e \n"Please Install \"${MASTER1_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
while [ "$(ssh core@${MASTER1_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${MASTER1_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
echo -e "\n${MASTER1_HOSTNAME}.${ClusterName}.${DomainName} Installed !"

echo -e "\nPlease Install \"${MASTER2_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
while [ "$(ssh core@${MASTER2_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${MASTER2_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
echo -e "\n${MASTER2_HOSTNAME}.${ClusterName}.${DomainName} Installed !"

echo -e "\nPlease Install \"${MASTER3_HOSTNAME}.${ClusterName}.${DomainName}\" Node"
while [ "$(ssh core@${MASTER3_HOSTNAME}.${ClusterName}.${DomainName} 'hostname' 2> /dev/null)" != "${MASTER3_HOSTNAME}.${ClusterName}.${DomainName}" ];do sleep 10;echo -n ".";done
echo -e "\n${MASTER3_HOSTNAME}.${ClusterName}.${DomainName} Installed !"

echo -ne "\nExecute Command: openshift-install wait-for bootstrap-complete --dir=${OKD_HOME} --log-level debug"
for i in $(seq 1 3);do echo -n '.';done && echo
openshift-install wait-for bootstrap-complete --dir=${OKD_HOME} --log-level debug
