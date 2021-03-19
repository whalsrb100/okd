#!/bin/bash
source src/env

N=$(cat /etc/haproxy/haproxy.cfg | grep ${BOOTSTRAP_HOSTNAME} | wc -l)
cat /etc/haproxy/haproxy.cfg | grep ${BOOTSTRAP_HOSTNAME}
sed -i '/${BOOTSTRAP_HOSTNAME}/s/^/#/g' /etc/haproxy/haproxy.cfg
cat /etc/haproxy/haproxy.cfg | grep ${BOOTSTRAP_HOSTNAME}
systemctl reload haproxy
if [ $(cat /etc/haproxy/haproxy.cfg | grep ${BOOTSTRAP_HOSTNAME} | grep ^'#' | wc -l) -eq ${N} ];then
  echo "OK"
else
  echo "NOK"
fi
