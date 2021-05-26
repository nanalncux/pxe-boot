#!/bin/bash
iface1=$(ip a |grep mtu | grep -v lo |head -n1 | sed 's/\://g' | awk '{print $2}')
cat > /etc/netplan/00-unstaller-config.yaml << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    $iface1:
      addresses:
      - 192.168.1.25/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
        - 8.8.8.8
        - 8.8.4.4
EOF
rm -f /etc/netplan/01-netcfg.yaml
