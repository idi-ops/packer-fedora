#!/bin/bash -eux

# Install Google Chrome
rpm --import https://dl-ssl.google.com/linux/linux_signing_key.pub

cat <<-EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF

# Vagrant requirements
${PKG_MGR} install -y ansible curl bzip2 deltarpm gcc git kernel-devel kernel-headers make net-tools nfs-utils orca perl sqlite-devel sudo tar wget yum-utils zlib-devel

# The remaining packages are GPII Framework dependencies - https://github.com/gpii/linux
${PKG_MGR} install -y glib2-devel PackageKit-glib-devel json-glib-devel libXrandr-devel libXrender-devel libX11-devel xorg-x11-proto-devel alsa-lib-devel tuxguitar firefox google-chrome-stable
