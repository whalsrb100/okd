#!/bin/bash
source src/env

LOG_FILE="${0}_log"
dnf install -y tar bzip2 gzip xz jq git rsync vim net-tools sos sysstat bind bind-utils podman httpd-tools \
	dhcp-server tftp-server httpd syslinux libvirt-libs wget haproxy expect | tee ${LOG_FILE}

systemctl enable --now io.podman.service io.podman.socket podman.socket
