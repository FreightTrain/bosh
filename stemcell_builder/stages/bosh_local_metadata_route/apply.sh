#!/usr/bin/env bash

# Matt Johnson <matjohn2@cisco.com> 24th September 2014

set -e

base_dir=$(readlink -nf $(dirname $0)/../..)
source $base_dir/lib/prelude_apply.bash
source $base_dir/lib/prelude_bosh.bash

# Problem: Openstack installations with a non-routed metadata service.
# Solution: Require local route 169.254.169.254/32 dev eth0
# Compatability: Ubuntu stemcells only (file structure different for CentOS)

cat <<EOF > $chroot/etc/network/if-up.d/ft-metadata
#!/bin/sh

set -e
PATH=/sbin:/bin

ip route add 169.254.169.254/32 dev eth0 && exit 0
EOF

chmod +x $chroot/etc/network/if-up.d/ft-metadata
