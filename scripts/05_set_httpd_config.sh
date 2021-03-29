#!/bin/bash
source src/env
ln -s var/www/html /html
sed -i 's/^Listen 80$/Listen 8080/' /etc/httpd/conf/httpd.conf
systemctl enable --now httpd
