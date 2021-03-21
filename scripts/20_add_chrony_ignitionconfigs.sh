#!/bin/bash
source src/env
cp -a ${OKD_HOME}/bootstrap.ign ${OKD_HOME}/bootstrap.ign_backup
cp -a ${OKD_HOME}/worker.ign ${OKD_HOME}/worker.ign_backup
cp -a ${OKD_HOME}/master.ign ${OKD_HOME}/master.ign_backup

cat ${OKD_HOME}/bootstrap.ign | jq '.' > ${OKD_HOME}/jq_bootstrap.ign
cat ${OKD_HOME}/worker.ign | jq '.' > ${OKD_HOME}/jq_worker.ign
cat ${OKD_HOME}/master.ign | jq '.' > ${OKD_HOME}/jq_master.ign

sed -i "/\"files\":/a\{\"overwrite\":true,\"path\":\"\/etc\/chrony.conf\",\"user\":{\"name\":\"root\"},\"contents\":{\"source\":\"data:text/plain;charset=utf-8;base64,$(echo "$(cat ${HTTP_HOME}/chrony.conf)" | base64 -w0)\"},\"mode\":420}," ${OKD_HOME}/jq_bootstrap.ign
sed -i "/^}/i\,\"storage\":{\"files\":[{\"overwrite\":true,\"path\":\"\/etc\/chrony.conf\",\"user\":{\"name\":\"root\"},\"contents\":{\"source\":\"data:text/plain;charset=utf-8;base64,$(echo "$(cat ${HTTP_HOME}/chrony.conf)" | base64 -w0)\"},\"mode\":420}]}" ${OKD_HOME}/jq_worker.ign
sed -i "/^}/i\,\"storage\":{\"files\":[{\"overwrite\":true,\"path\":\"\/etc\/chrony.conf\",\"user\":{\"name\":\"root\"},\"contents\":{\"source\":\"data:text/plain;charset=utf-8;base64,$(echo "$(cat ${HTTP_HOME}/chrony.conf)" | base64 -w0)\"},\"mode\":420}]}" ${OKD_HOME}/jq_master.ign

cat ${OKD_HOME}/jq_bootstrap.ign | jq -c '.' > ${OKD_HOME}/bootstrap.ign
cat ${OKD_HOME}/jq_worker.ign | jq -c '.' > ${OKD_HOME}/worker.ign
cat ${OKD_HOME}/jq_master.ign | jq -c '.' > ${OKD_HOME}/master.ign

rm -f ${OKD_HOME}/jq_bootstrap.ign
rm -f ${OKD_HOME}/jq_worker.ign
rm -f ${OKD_HOME}/jq_master.ign


chown apache. -R ${HTTP_HOME}
echo 'Please distrubete bootstrap, master'
