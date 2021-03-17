#!/bin/bash

cat << EOF > /var/www/html/install-config.yaml
apiVersion: v1
baseDomain: ${DomainName}
metadata:
  name: ${ClusterName}

compute:
- hyperthreading: Enabled
  name: worker
  replicas: 0

controlPlane:
  hyperthreading: Enabled
  name: master
  replicas: 3

networking:
  clusterNetwork:
  - cidr: 10.128.0.0/14 
    hostPrefix: 23 
  networkType: OpenShiftSDN
  serviceNetwork: 
  - 172.30.0.0/16

platform:
  none: {}

fips: false

pullSecret: '{"auths":{"${BASTION_HOSTNAME}.${ClusterName}.${DomainName}:5000":{"auth":"YWRtaW46YWRtaW4="}}}'
sshKey: '$(cat /root/.ssh/id_rsa.pub)'
additionalTrustBundle: |
$(cat ${CRT} | sed -s '/^/  /g')
imageContentSources:
- mirrors:
  - ${BASTION_HOSTNAME}.${ClusterName}.${DomainName}:5000/openshift/okd
  source: quay.io/openshift/okd
- mirrors:
  - ${BASTION_HOSTNAME}.${ClusterName}.${DomainName}:5000/openshift/okd
  source: quay.io/openshift/okd-content
EOF
rm -rf /var/www/html/okd
mkdir /var/www/html/okd/
cp /var/www/html/install-config.yaml /var/www/html/okd/
chown apache. -R /var/www/html/
