#!/bin/bash -eux

iptables -A OUTPUT -p tcp --dport 21 -j REJECT

echo "==> Configuring sshd_config options"

echo "==> Turning off sshd DNS lookup to prevent timeout delay"
echo "UseDNS no" >> /etc/ssh/sshd_config
echo "==> Disabling GSSAPI authentication to prevent timeout delay"
echo "GSSAPIAuthentication no" >> /etc/ssh/sshd_config
