#!/bin/bash
sed -i 's/SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
setenforce 0
systemctl disable --now firewalld
sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/*
cat << EOF > /etc/yum.repos.d/local.repo
[AppStream_iso]
name=AppStream_iso
baseurl=file:///media/AppStream
gpgcheck=0
enabled=1

[BaseOS_iso]
name=BaseOS_iso
baseurl=file:///media/BaseOS
gpgcheck=0
enabled=1
EOF
echo 'set local yum repository after mount to "/media"'
