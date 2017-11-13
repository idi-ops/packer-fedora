#!/bin/bash -eux

dnf install -y docker
systemctl enable docker
groupadd docker
usermod -a -G docker vagrant
