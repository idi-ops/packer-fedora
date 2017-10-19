#!/bin/bash -eux
if [[ $UPDATE  =~ true || $UPDATE =~ 1 || $UPDATE =~ yes ]]; then
    echo "==> Applying updates"
    dnf -y update

    # reboot
    echo "Rebooting the machine..."
    systemctl stop sshd.service
    nohup shutdown -r now < /dev/null > /dev/null 2>&1 &
    exit 0
fi
