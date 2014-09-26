#!/usr/bin/env bash

set -e

base_dir=$(readlink -nf $(dirname $0)/../..)
source $base_dir/lib/prelude_apply.bash
source $base_dir/lib/prelude_bosh.bash


if [ "${DISTRIB_CODENAME}" == "lucid" ]; then
  cp $assets_dir/lucid/*.deb $chroot/tmp/

  run_in_chroot $chroot "dpkg -i /tmp/lucid-growroot_0.1ubuntu1~ppa0_all.deb"

  rm $chroot/tmp/*.deb
else
  echo "No installation candidate on this arch for growroot"
fi
