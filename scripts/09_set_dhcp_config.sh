#!/bin/bash
source src/env
src/create_config_for_dhcpd ${DHCPCONFIGFILE}
/usr/bin/mv -f ${DHCPCONFIGFILE} /etc/dhcp/
systemctl disable dhcpd
systemctl start dhcpd
