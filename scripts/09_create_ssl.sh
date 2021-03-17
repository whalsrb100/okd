#!/bin/bash
source src/env
mkdir -p /opt/registry/{auth,data,certs}
cd /opt/registry/certs
/usr/bin/openssl req -newkey rsa:4096 -nodes -sha256 \
-x509 -days 3650 \
-keyout domain.key \
-out domain.crt \
-subj "/C=KR/ST=Seoul/L=City/O=SelfSign/OU=Cloud/CN=${ClusterName}.${DomainName}}/emailAddress=${E_MAIL}"

#/usr/bin/cp -a domain.{key,crt} /opt/registry/certs
/usr/bin/cp -a domain.{key,crt} /etc/pki/ca-trust/source/anchors/
/usr/bin/update-ca-trust
