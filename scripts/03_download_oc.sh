#!/bin/bash
source src/env
######################################
# 2021-03-29 updated
# Ver=4.7.0-0.okd-2021-03-28-152009
# Ver=4.7.0-0.okd-2021-03-21-094146
# Ver=4.7.0-0.okd-2021-03-07-090821
# Ver=4.7.0-0.okd-2021-03-06-124908
# Ver=4.7.0-0.okd-2021-02-25-144700
# Ver=4.6.0-0.okd-2021-02-14-205305
# Ver=4.6.0-0.okd-2021-01-23-132511
# Ver=4.6.0-0.okd-2021-01-17-185703
# Ver=4.6.0-0.okd-2020-12-12-135354
# Ver=4.6.0-0.okd-2020-11-27-200126
# Ver=4.5.0-0.okd-2020-10-15-235428
# Ver=4.5.0-0.okd-2020-10-03-012432
# Ver=4.5.0-0.okd-2020-09-18-202631
# Ver=4.5.0-0.okd-2020-09-04-180756
# Ver=4.5.0-0.okd-2020-08-12-020541
# Ver=4.5.0-0.okd-2020-07-29-070316
# Ver=4.5.0-0.okd-2020-07-14-153706
# Ver=4.5.0-0.okd-2020-07-12-134038-rc
# Ver=4.5.0-0.okd-2020-06-29-110348-beta6
# Ver=4.4.0-0.okd-2020-05-23-055148-beta5
# Ver=4.4.0-0.okd-2020-04-21-163702-beta4
# Ver=4.4.0-0.okd-2020-04-16-074048-beta3
# Ver=4.4.0-0.okd-2020-04-07-175212-beta2
# Ver=4.4.0-0.okd-2020-03-28-092308
# Ver=4.4.0-0.okd-2020-01-28-022517
# Ver=4.3.0-0.okd-2019-11-15-182656
######################################
Ver='4.7.0-0.okd-2021-03-28-152009'
function EXEC(){
CMD="${1}"
expect -c "
set timeout 5
spawn ${CMD}
expect 'password:'
	send \"growin\"
expect eof
"
}

Ver="4.6.0-0.okd-2021-02-14-205305"
if [ "$(echo ${ONPREMIS} | tr [:upper:] [:lower:])" == "true" ];then
  echo "[ ONPREMIS=\"true\" ] Can not down load openshift-client, openshift-install programs."
  REMOTEUSER="root"
  REMOTEADDR="192.168.150.129"
  REMOTEPATH="/data/mj_tmp/oc"
  ClientFileName="openshift-client-linux-${Ver}.tar.gz"
  InstallFileName="openshift-install-linux-${Ver}.tar.gz"
  rsync -avrP ${REMOTEUSER}@${REMOTEADDR}:${REMOTEPATH}/${Ver}/{${ClientFileName},${InstallFileName}} ./
 
  #EXEC "ssh -l ${REMOTEUSER} ${REMOTEADDR} cat ${REMOTEPATH}/${Ver}/${ClientFileName} | tar -C /usr/local/bin/ -xfz -"
  #EXEC "ssh -l ${REMOTEUSER} ${REMOTEADDR} cat ${REMOTEPATH}/${Ver}/${InstallFileName} | tar -C /usr/local/bin/ -xfz -"
else
  # openshift-client
  wget https://github.com/openshift/okd/releases/download/${Ver}/openshift-client-linux-${Ver}.tar.gz
  tar xf openshift-client-linux-${Ver}.tar.gz -C /usr/local/bin/
  # openshift-install
  wget https://github.com/openshift/okd/releases/download/${Ver}/openshift-install-linux-${Ver}.tar.gz
  tar xf openshift-install-linux-${Ver}.tar.gz -C /usr/local/bin/
fi
exit 0
