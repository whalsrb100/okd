#!/bin/bash
source src/env
mkdir -p /opt/registry/{auth,data,certs}
/usr/bin/openssl req -newkey rsa:4096 -nodes -sha256 \
-x509 -days 3650 \
-keyout ${KEY} \
-out ${CRT} \
-subj "/C=KR/ST=Seoul/L=City/O=SelfSign/OU=Cloud/CN=${ClusterName}.${DomainName}}/emailAddress=${E_MAIL}"

/usr/bin/cp -a ${KEY} ${CRT} /etc/pki/ca-trust/source/anchors/
/usr/bin/update-ca-trust
