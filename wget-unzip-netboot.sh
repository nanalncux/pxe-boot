#!/bin/bash
wget http://archive.ubuntu.com/ubuntu/dists/focal/main/installer-amd64/current/legacy-images/netboot/netboot.tar.gz -O /var/lib/tftpboot/netboot.tar.gz
cd /var/lib/tftpboot/
tar xvzf ./netboot.tar.gz