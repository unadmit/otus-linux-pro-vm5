#!/bin/bash
echo 'nfsc_script.sh'
sudo yum -y install nfs-utils
sudo systemctl enable firewalld --now
sudo systemctl status firewalld
echo "192.168.50.10:/srv/share/ /mnt nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0" | sudo tee -a /etc/fstab
sudo systemctl daemon-reload
sudo systemctl restart remote-fs.target
ls -la /mnt
mount | grep mnt
ls -la /mnt/upload/
touch /mnt/upload/client_file