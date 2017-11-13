#!/bin/sh

cat <<-EOF > /usr/local/bin/edit-hosts.sh
#!/bin/sh
# Using config.vm.hostname to set the hostname on Fedora VMs seems to remove the string
# "localhost" from the first line of /etc/hosts. This script reinserts it if it's missing.

grep -q '127.0.0.1 localhost' /etc/hosts || sed -i 's/\(127.0.0.1\)/\1 localhost/' /etc/hosts
EOF

chmod +x /usr/local/bin/edit-hosts.sh
