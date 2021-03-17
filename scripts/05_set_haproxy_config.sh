#!/bin/bash
source src/env
cat << EOF > /etc/haproxy/haproxy.cfg
#---------------------------------------------------------------------
# Example configuration for a possible web application.  See the
# full configuration options online.
#
#   https://www.haproxy.org/download/1.8/doc/configuration.txt
#
#---------------------------------------------------------------------

#---------------------------------------------------------------------
# Global settings
#---------------------------------------------------------------------
global
    # to have these messages end up in /var/log/haproxy.log you will
    # need to:
    #
    # 1) configure syslog to accept network log events.  This is done
    #    by adding the '-r' option to the SYSLOGD_OPTIONS in
    #    /etc/sysconfig/syslog
    #
    # 2) configure local2 events to go to the /var/log/haproxy.log
    #   file. A line like the following can be added to
    #   /etc/sysconfig/syslog
    #
    #    local2.*                       /var/log/haproxy.log
    #
    log         127.0.0.1 local2

    chroot      /var/lib/haproxy
    pidfile     /var/run/haproxy.pid
    maxconn     4000
    user        haproxy
    group       haproxy
    daemon

    # turn on stats unix socket
    stats socket /var/lib/haproxy/stats

    # utilize system-wide crypto-policies
    ssl-default-bind-ciphers PROFILE=SYSTEM
    ssl-default-server-ciphers PROFILE=SYSTEM

#---------------------------------------------------------------------
# common defaults that all the 'listen' and 'backend' sections will
# use if not designated in their block
#---------------------------------------------------------------------
defaults
    mode                    http
    log                     global
    option                  httplog
    option                  dontlognull
    option http-server-close
    option forwardfor       except 127.0.0.0/8
    option                  redispatch
    retries                 3
    timeout http-request    10s
    timeout queue           1m
    timeout connect         10s
    timeout client          1m
    timeout server          1m
    timeout http-keep-alive 10s
    timeout check           10s
    maxconn                 3000

#---------------------------------------------------------------------
# main frontend which proxys to the backends
#---------------------------------------------------------------------
#frontend main
#    bind *:5000
#    acl url_static       path_beg       -i /static /images /javascript /stylesheets
#    acl url_static       path_end       -i .jpg .gif .png .css .js
#
#    use_backend static          if url_static
#    default_backend             app

#---------------------------------------------------------------------
# static backend for serving up images, stylesheets and such
#---------------------------------------------------------------------
backend static
    balance     roundrobin
    server      static 127.0.0.1:4331 check

#---------------------------------------------------------------------
# round robin balancing between the various backends
#---------------------------------------------------------------------
backend app
    balance     roundrobin
    server  app1 127.0.0.1:5001 check
    server  app2 127.0.0.1:5002 check
    server  app3 127.0.0.1:5003 check
    server  app4 127.0.0.1:5004 check

frontend openshift-api-server
    bind *:6443
    default_backend openshift-api-server
    mode tcp
    option tcplog
backend openshift-api-server
    balance source
    mode tcp
    server ${BOOTSTRAP_HOSTNAME} ${BOOTSTRAP_IP}:6443 check
    server ${MASTER1_HOSTNAME} ${MASTER1_IP}:6443 check
    server ${MASTER2_HOSTNAME} ${MASTER2_IP}:6443 check
    server ${MASTER3_HOSTNAME} ${MASTER3_IP}:6443 check
frontend machine-config-server
    bind *:22623
    default_backend machine-config-server
    mode tcp
    option tcplog
backend machine-config-server
    balance source
    mode tcp
    server ${BOOTSTRAP_HOSTNAME} ${BOOTSTRAP_IP}:22623 check
    server ${MASTER1_HOSTNAME} ${MASTER1_IP}:22623 check
    server ${MASTER2_HOSTNAME} ${MASTER2_IP}:22623 check
    server ${MASTER3_HOSTNAME} ${MASTER3_IP}:22623 check
frontend ingress-http
    bind *:80
    default_backend ingress-http
    mode tcp
    option tcplog
backend ingress-http
    balance source
    mode tcp
    server ${WORKER1_HOSTNAME} ${WORKER1_IP}:80 check
    server ${WORKER2_HOSTNAME} ${WORKER2_IP}:80 check
    server ${WORKER3_HOSTNAME} ${WORKER3_IP}:80 check
    server ${WORKER4_HOSTNAME} ${WORKER4_IP}:80 check
frontend ingress-https
    bind *:443
    default_backend ingress-https
    mode tcp
    option tcplog
backend ingress-https
    balance source
    mode tcp
    server ${WORKER1_HOSTNAME} ${WORKER1_IP}:443 check
    server ${WORKER2_HOSTNAME} ${WORKER2_IP}:443 check
    server ${WORKER3_HOSTNAME} ${WORKER3_IP}:443 check
    server ${WORKER4_HOSTNAME} ${WORKER4_IP}:443 check
EOF
systemctl enable --now haproxy
