#!/bin/bash -eux

echo "==> Applying updates"
dnf -y update

echo "Rebooting the machine..."
systemctl stop sshd.service
nohup shutdown -r now < /dev/null > /dev/null 2>&1 &
exit 0
