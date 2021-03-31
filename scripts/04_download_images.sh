#!/bin/bash
source src/env
# ISO IMAGE
#https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/${Ver}/x86_64/fedora-coreos-${Ver}-live.x86_64.iso

#Ver='33.20210301.3.1'
#Ver='33.20210217.3.0'
#Ver='33.20210201.3.0'
#Ver='33.20210117.3.2'
#Ver='32.20201104.3.0'

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
echo "Version: ${Ver}"
