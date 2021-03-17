#!/bin/bash
source src/env

mkdir /var/lib/tftpboot/pxelinux.cfg/
cp /usr/share/syslinux/{menu.c32,ldlinux.c32,libutil.c32,pxelinux.0} /var/lib/tftpboot/
cat << EOF > /var/lib/tftpboot/pxelinux.cfg/default
default menu.c32
prompt 0
#timeout 20

LABEL ${BOOTSTRAP_HOSTNAME}
menu label ${BOOTSTRAP_HOSTNAME}
KERNEL ${kernel_file}
APPEND ksdevice=bootif initrd=${initrd_img} network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://${BASTION_IP}:8080/${rootfs_img} coreos.inst.install_dev=vda coreos.inst.ignition_url=http://${BASTION_IP}:8080/okd/${BOOTSTRAP_HOSTNAME}.ign ip=${BOOTSTRAP_IP}::${BASTION_IP}:${SubnetMask}:${BOOTSTRAP_HOSTNAME}.${ClusterName}.${DomainName}:${PxeIfname}:none nameserver=${BASTION_IP}
IPAPPEND 2

LABEL ${MASTER1_HOSTNAME}
menu label ${MASTER1_HOSTNAME}
KERNEL ${kernel_file}
APPEND ksdevice=bootif initrd=${initrd_img} network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://${BASTION_IP}:8080/${rootfs_img} coreos.inst.install_dev=vda coreos.inst.ignition_url=http://${BASTION_IP}:8080/okd/master.ign ip=${MASTER1_IP}::${BASTION_IP}:${SubnetMask}:${MASTER1_HOSTNAME}.${ClusterName}.${DomainName}:${PxeIfname}:none nameserver=${BASTION_IP}
IPAPPEND 2

LABEL ${MASTER2_HOSTNAME}
menu label ${MASTER2_HOSTNAME}
KERNEL ${kernel_file}
APPEND ksdevice=bootif initrd=${initrd_img} network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://${BASTION_IP}:8080/${rootfs_img} coreos.inst.install_dev=vda coreos.inst.ignition_url=http://${BASTION_IP}:8080/okd/master.ign ip=${MASTER2_IP}::${BASTION_IP}:${SubnetMask}:${MASTER2_HOSTNAME}.${ClusterName}.${DomainName}:${PxeIfname}:none nameserver=${BASTION_IP}
IPAPPEND 2

LABEL ${MASTER3_HOSTNAME}
menu label ${MASTER3_HOSTNAME}
KERNEL ${kernel_file}
APPEND ksdevice=bootif initrd=${initrd_img} network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://${BASTION_IP}:8080/${rootfs_img} coreos.inst.install_dev=vda coreos.inst.ignition_url=http://${BASTION_IP}:8080/okd/master.ign ip=${MASTER3_IP}::${BASTION_IP}:${SubnetMask}:${MASTER3_HOSTNAME}.${ClusterName}.${DomainName}:${PxeIfname}:none nameserver=${BASTION_IP}
IPAPPEND 2

LABEL ${WORKER1_HOSTNAME}
menu label ${WORKER1_HOSTNAME}
KERNEL ${kernel_file}
APPEND ksdevice=bootif initrd=${initrd_img} network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://${BASTION_IP}:8080/${rootfs_img} coreos.inst.install_dev=vda coreos.inst.ignition_url=http://${BASTION_IP}:8080/okd/worker.ign ip=${WORKER1_IP}::${BASTION_IP}:${SubnetMask}:${WORKER1_HOSTNAME}.${ClusterName}.${DomainName}:${PxeIfname}:none nameserver=${BASTION_IP}
IPAPPEND 2

LABEL ${WORKER2_HOSTNAME}
menu label ${WORKER2_HOSTNAME}
KERNEL ${kernel_file}
APPEND ksdevice=bootif initrd=${initrd_img} network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://${BASTION_IP}:8080/${rootfs_img} coreos.inst.install_dev=vda coreos.inst.ignition_url=http://${BASTION_IP}:8080/okd/worker.ign ip=${WORKER2_IP}::${BASTION_IP}:${SubnetMask}:${WORKER2_HOSTNAME}.${ClusterName}.${DomainName}:${PxeIfname}:none nameserver=${BASTION_IP}
IPAPPEND 2

LABEL ${WORKER3_HOSTNAME}
menu label ${WORKER3_HOSTNAME}
KERNEL ${kernel_file}
APPEND ksdevice=bootif initrd=${initrd_img} network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://${BASTION_IP}:8080/${rootfs_img} coreos.inst.install_dev=vda coreos.inst.ignition_url=http://${BASTION_IP}:8080/okd/worker.ign ip=${WORKER3_IP}::${BASTION_IP}:${SubnetMask}:${WORKER3_HOSTNAME}.${ClusterName}.${DomainName}:${PxeIfname}:none nameserver=${BASTION_IP}

LABEL ${WORKER4_HOSTNAME}
menu label ${WORKER4_HOSTNAME}
KERNEL ${kernel_file}
APPEND ksdevice=bootif initrd=${initrd_img} network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://${BASTION_IP}:8080/${rootfs_img} coreos.inst.install_dev=vda coreos.inst.ignition_url=http://${BASTION_IP}:8080/okd/worker.ign ip=${WORKER4_IP}::${BASTION_IP}:${SubnetMask}:${WORKER4_HOSTNAME}.${ClusterName}.${DomainName}:${PxeIfname}:none nameserver=${BASTION_IP}
IPAPPEND 2
EOF
systemctl disable tftp.socket
systemctl start tftp.socket

