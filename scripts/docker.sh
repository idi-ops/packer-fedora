#!/bin/bash -eux

# This ugly hack is necessary because Docker doesn't build stable packages
# for new distributions. When Fedora 28 was released, the Docker CE 18.03
# packages weren't built for it. Docker will only release packages for
# Fedora 28 in their stable channel when Docker CE 18.05 is released.
#
# Instead of using the test/edge channels, which would bring Docker CE 18.05,
# we simply use the stable packages for Fedora 27 here.
#
# This can be removed once Docker CE 18.05 is released but might be needed
# again when Fedora 29 is released, until newer Docker CE packages are 
# released. It's insane.
#
# Since the packer-fedora repository supports two Fedora releases, it might
# be better to always keep this pointed to the $last-1 release.

dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sed -i -e 's/$releasever/27/g' /etc/yum.repos.d/docker-ce.repo
dnf install -y docker-ce
systemctl enable docker
groupadd docker
usermod -a -G docker vagrant
