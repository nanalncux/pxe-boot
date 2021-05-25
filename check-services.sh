#!/bin/bash
echo 'DHCP STATUS'
service isc-dhcp-server status | grep Active
ls -la /etc/dhcp/dhcpd.conf | awk '{print$7$6$8$9}'
echo 'TFTP STATUS'
service tftpd-hpa status | grep Active
ls -la /etc/default/tftpd-hpa | awk '{print$7$6$8$9}'
echo 'NGINX STATUS'
service nginx status | grep Active
ls -la /etc/nginx/sites-available/default | awk '{print$7$6$8$9}'
