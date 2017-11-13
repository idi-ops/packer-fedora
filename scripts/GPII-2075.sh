#!/bin/bash

# This script is used to add a dnf workaround described at
# https://issues.gpii.net/browse/GPII-2075

sed -i '/\[main\]/ a timeout=10000' /etc/dnf/dnf.conf

