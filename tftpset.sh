#!/bin/bash
mkdir /var/lib/tftpboot/pxelinux.cfg/
cp /usr/share/syslinux/{menu.c32,ldlinux.c32,libutil.c32,pxelinux.0} /var/lib/tftpboot/
cat << EOF > /var/lib/tftpboot/pxelinux.cfg/default
default menu.c32
prompt 0
#timeout 20

LABEL bootstrap
menu label bootstrap
KERNEL b_img/fcos/vmlinuz
APPEND ksdevice=bootif initrd=b_img/fcos/initrd.img network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://192.168.150.210:8080/rootfs.img coreos.inst.install_dev=vda coreos.inst.ignition_url=http://192.168.150.210:8080/okd/bootstrap.ign ip=192.168.150.200::192.168.150.210:255.255.255.128:bootstrap.growin.mj.co.kr:enp3s0:none nameserver=192.168.150.210
IPAPPEND 2

LABEL master1
menu label master1
KERNEL b_img/fcos/vmlinuz
APPEND ksdevice=bootif initrd=b_img/fcos/initrd.img network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://192.168.150.210:8080/rootfs.img coreos.inst.install_dev=vda coreos.inst.ignition_url=http://192.168.150.210:8080/okd/master.ign ip=192.168.150.201::192.168.150.210:255.255.255.128:master1.growin.mj.co.kr:enp3s0:none nameserver=192.168.150.210
IPAPPEND 2

LABEL master2
menu label master2
KERNEL b_img/fcos/vmlinuz
APPEND ksdevice=bootif initrd=b_img/fcos/initrd.img network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://192.168.150.210:8080/rootfs.img coreos.inst.install_dev=vda coreos.inst.ignition_url=http://192.168.150.210:8080/okd/master.ign ip=192.168.150.202::192.168.150.210:255.255.255.128:master2.growin.mj.co.kr:enp3s0:none nameserver=192.168.150.210
IPAPPEND 2

LABEL master3
menu label master3
KERNEL b_img/fcos/vmlinuz
APPEND ksdevice=bootif initrd=b_img/fcos/initrd.img network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://192.168.150.210:8080/rootfs.img coreos.inst.install_dev=vda coreos.inst.ignition_url=http://192.168.150.210:8080/okd/master.ign ip=192.168.150.203::192.168.150.210:255.255.255.128:master3.growin.mj.co.kr:enp3s0:none nameserver=192.168.150.210
IPAPPEND 2

LABEL worker1
menu label worker1
KERNEL b_img/fcos/vmlinuz
APPEND ksdevice=bootif initrd=b_img/fcos/initrd.img network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://192.168.150.210:8080/rootfs.img coreos.inst.install_dev=vda coreos.inst.ignition_url=http://192.168.150.210:8080/okd/worker.ign ip=192.168.150.204::192.168.150.210:255.255.255.128:worker1.growin.mj.co.kr:enp3s0:none nameserver=192.168.150.210
IPAPPEND 2

LABEL worker2
menu label worker2
KERNEL b_img/fcos/vmlinuz
APPEND ksdevice=bootif initrd=b_img/fcos/initrd.img network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://192.168.150.210:8080/rootfs.img coreos.inst.install_dev=vda coreos.inst.ignition_url=http://192.168.150.210:8080/okd/worker.ign ip=192.168.150.205::192.168.150.210:255.255.255.128:worker2.growin.mj.co.kr:enp3s0:none nameserver=192.168.150.210
IPAPPEND 2

LABEL worker3
menu label worker3
KERNEL b_img/fcos/vmlinuz
APPEND ksdevice=bootif initrd=b_img/fcos/initrd.img network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://192.168.150.210:8080/rootfs.img coreos.inst.install_dev=vda coreos.inst.ignition_url=http://192.168.150.210:8080/okd/worker.ign ip=192.168.150.206::192.168.150.210:255.255.255.128:worker3.growin.mj.co.kr:enp3s0:none nameserver=192.168.150.210

LABEL worker4
menu label worker4
KERNEL b_img/fcos/vmlinuz
APPEND ksdevice=bootif initrd=b_img/fcos/initrd.img network console=tty0 console=ttyS0 coreos.live.rootfs_url=http://192.168.150.210:8080/rootfs.img coreos.inst.install_dev=vda coreos.inst.ignition_url=http://192.168.150.210:8080/okd/worker.ign ip=192.168.150.207::192.168.150.210:255.255.255.128:worker4.growin.mj.co.kr:enp3s0:none nameserver=192.168.150.210
IPAPPEND 2


EOF
