#!/bin/sh

# Check whether all required variables are set
if ! [ -v NAME -a -v IMAGE ] ; then
  echo "Environment variables NAME, IMAGE must be set."
  exit 1
fi

data_dir="/var/lib/${NAME}"

chroot "/host" /usr/bin/systemctl disable "${NAME}.service"
chroot "/host" /usr/bin/systemctl stop "${NAME}.service"
rm -f "/host/etc/systemd/system/${NAME}.service"
