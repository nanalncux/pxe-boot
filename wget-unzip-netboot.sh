#!/bin/bash
wget http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/netboot.tar.gz -O /var/lib/tftpboot/netboot.tar.gz
cd /var/lib/tftpboot/
tar xvzf ./netboot.tar.gz
#wget http://old-releases.ubuntu.com/releases/20.04/ubuntu-20.04-live-server-amd64.iso -O /var/lib/tftpboot/