#!/bin/bash
openshift-install create ignition-configs --dir=/var/www/html/okd
chown apache. -R /var/www/html/
echo 'Please distrubete bootstrap, master'
