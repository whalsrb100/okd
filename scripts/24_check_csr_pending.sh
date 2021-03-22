#!/bin/bash
source src/env
export KUBECONFIG=${OKD_HOME}/auth/kubeconfig

Approve_count=0
while [ ${Approve_count} -lt $(expr ${Approve_count} \* 2) ];do
Approve_count=$(expr ${Approve_count} \+ $(oc get csr | grep Pending | awk '{print "oc adm certificate approve "$1}' | wc -l))
oc get csr | grep Pending | awk '{print "oc adm certificate approve "$1}'| sh
done
