#!/bin/bash
source src/env
openshift-install create manifests --dir=${OKD_HOME}
openshift-install create ignition-configs --dir=${OKD_HOME}

chown apache. -R ${HTTP_HOME}/

