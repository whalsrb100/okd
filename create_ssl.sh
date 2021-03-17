#!/bin/bash
/usr/bin/openssl req -newkey rsa:4096 -nodes -sha256 \
-x509 -days 36500 \
-keyout domain.key \
-out domain.crt \
-subj "/C=KR/ST=Seoul/L=City/O=SelfSign/OU=Cloud/CN=bastion.growin.mj.co.kr/emailAddress=mj@growin.co.kr"

/usr/bin/cp -a domain.{key,crt} /opt/registry/certs
/usr/bin/cp -a domain.{key,crt} /etc/pki/ca-trust/source/anchors/
/usr/bin/update-ca-trust
