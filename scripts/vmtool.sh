#!/bin/bash -eux


echo "==> Installing VirtualBox guest additions"

if [ "${PKG_MGR}" == "dnf" ]; then
  dnf -y install kernel-headers-$(uname -r) kernel-devel-$(uname -r) gcc make perl
fi

VBOX_VERSION=$(cat /home/vagrant/.vbox_version)
mount -o loop /home/vagrant/VBoxGuestAdditions_${VBOX_VERSION}.iso /mnt
sh /mnt/VBoxLinuxAdditions.run --nox11
umount /mnt
rm -rf /home/vagrant/VBoxGuestAdditions_${VBOX_VERSION}.iso
rm -f /home/vagrant/.vbox_version

echo "==> Removing packages needed for building guest tools"
dnf -y remove gcc cpp kernel-devel kernel-headers perl
