#!/bin/bash -eux

dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
dnf install -y docker-ce grubby
systemctl enable docker
groupadd docker
usermod -a -G docker vagrant

grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"
