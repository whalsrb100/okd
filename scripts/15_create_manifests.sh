#!/bin/bash
openshift-install create manifests --dir=/var/www/html/okd
openshift-install create ignition-configs --dir=/var/www/html/okd

chown apache. -R /var/www/html/

