#!/bin/bash
echo 'nfss_script.sh'
sudo yum -y install nfs-utils
sudo systemctl enable firewalld --now
sudo systemctl status firewalld
sudo firewall-cmd --add-service="nfs3" --add-service="rpc-bind" --add-service="mountd" --permanent
sudo firewall-cmd --reload
sudo systemctl enable nfs --now
ss -tnplu
sudo mkdir -p /srv/share/upload
sudo chown -R nfsnobody:nfsnobody /srv/share
sudo chmod 0777 /srv/share/upload
echo '/srv/share 192.168.50.11/32(rw,sync,root_squash)' | sudo tee /etc/exports
sudo exportfs -r
sudo exportfs -s
touch /srv/share/upload/check_file
ls -la /srv/share/upload/