#!/bin/bash
source src/env
# ISO IMAGE
#https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/${Ver}/x86_64/fedora-coreos-${Ver}-live.x86_64.iso

# 2021-03-29 updated list
# Ver=33.20210301.3.1
# Ver=33.20210217.3.0
# Ver=33.20210201.3.0
# Ver=33.20210117.3.2
# Ver=33.20210117.3.1
# Ver=33.20210117.3.0
# Ver=33.20210104.3.1
# Ver=33.20210104.3.0
# Ver=33.20201214.3.1
# Ver=33.20201214.3.0
# Ver=33.20201201.3.0
# Ver=32.20201104.3.0
# Ver=32.20201018.3.0
# Ver=32.20201004.3.0
# Ver=32.20200923.3.0
# Ver=32.20200907.3.0
# Ver=32.20200824.3.0
# Ver=32.20200809.3.0
# Ver=32.20200726.3.1
# Ver=32.20200726.3.0
# Ver=32.20200715.3.0
# Ver=32.20200629.3.0
# Ver=32.20200615.3.0
# Ver=32.20200601.3.0
# Ver=31.20200517.3.0
# Ver=31.20200505.3.0
# Ver=31.20200420.3.0
# Ver=31.20200407.3.0
# Ver=31.20200323.3.2
# Ver=31.20200323.3.1
# Ver=31.20200323.3.0
# Ver=31.20200310.3.0
# Ver=31.20200223.3.0
# Ver=31.20200210.3.0
# Ver=31.20200127.3.0
# Ver=31.20200118.3.0
# Ver=31.20200113.3.1
# Ver=31.20200113.3.0
# Ver=31.20200108.3.0
# Ver=31.20191210.3.0

# 
#Ver='33.20210117.3.2'
Ver='33.20210301.3.1'

if [ "${ONPREMIS}" == "true" ];then
REMOTEUSER="root"
REMOTEADDR="192.168.150.129"
rsync -P ${REMOTEUSER}@${REMOTEADDR}:/data/mj_tmp/CoreOS_Images/${Ver}/fedora-coreos-${Ver}-live-kernel-x86_64 /var/lib/tftpboot/b_img/fcos/vmlinuz
rsync -P ${REMOTEUSER}@${REMOTEADDR}:/data/mj_tmp/CoreOS_Images/${Ver}/fedora-coreos-${Ver}-live-initramfs.x86_64.img /var/lib/tftpboot/b_img/fcos/initrd.img
rsync -P ${REMOTEUSER}@${REMOTEADDR}:/data/mj_tmp/CoreOS_Images/${Ver}/fedora-coreos-${Ver}-live-rootfs.x86_64.img ${HTTP_HOME}/img/rootfs.img
else
mkdir -p ${HTTP_HOME}/img/
rm -f /var/lib/tftpboot/b_img/fcos/vmlinuz
wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/${Ver}/x86_64/fedora-coreos-${Ver}-live-kernel-x86_64
mv fedora-coreos-${Ver}-live-kernel-x86_64 /var/lib/tftpboot/b_img/fcos/vmlinuz

rm -f /var/lib/tftpboot/b_img/fcos/initrd.img
https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/${Ver}/x86_64/fedora-coreos-${Ver}-live-initramfs.x86_64.img
mv fedora-coreos-${Ver}-live-initramfs.x86_64.img /var/lib/tftpboot/b_img/fcos/initrd.img

rm -f ${HTTP_HOME}/img/rootfs.img
https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/${Ver}/x86_64/fedora-coreos-${Ver}-live-rootfs.x86_64.img
mv fedora-coreos-${Ver}-live-rootfs.x86_64.img ${HTTP_HOME}/img/rootfs.img

fi
