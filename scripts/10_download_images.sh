#!/bin/bash
source src/env

mkdir -p ${HTTP_HOME}/img/
wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/33.20210217.3.0/x86_64/fedora-coreos-33.20210217.3.0-live-rootfs.x86_64.img -o ${HTTP_HOME}/img/rootfs.img
wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/33.20210217.3.0/x86_64/fedora-coreos-33.20210217.3.0-live-rootfs.x86_64.img.sig -o ${HTTP_HOME}/img/rootfs.img.sig

mkdir -p /var/lib/tftpboot/b_img/fcos
wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/33.20210217.3.0/x86_64/fedora-coreos-33.20210217.3.0-live-kernel-x86_64 -o /var/lib/tftpboot/b_img/fcos/vmlinuz
wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/33.20210217.3.0/x86_64/fedora-coreos-33.20210217.3.0-live-kernel-x86_64.sig -o /var/lib/tftpboot/b_img/fcos/vmlinuz.sig
wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/33.20210217.3.0/x86_64/fedora-coreos-33.20210217.3.0-live-initramfs.x86_64.img -o /var/lib/tftpboot/b_img/fcos/initrd.img
wget https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/33.20210217.3.0/x86_64/fedora-coreos-33.20210217.3.0-live-initramfs.x86_64.img.sig -o /var/lib/tftpboot/b_img/fcos/initrd.img.sig
