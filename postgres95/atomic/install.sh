#!/bin/sh

# Check whether all required variables are set
if ! [ -v NAME -a -v IMAGE ] ; then
  echo "Environment variables NAME, IMAGE must be set."
  exit 1
fi

data_dir="/var/lib/${NAME}"

# Create directories on host from spc
mkdir -p "/host/${data_dir}"
chcon -Rt svirt_sandbox_file_t "/host/${data_dir}"
chown -R postgres:postgres "/host/${data_dir}"
chmod -R 700 "/host/${data_dir}"

# create container on host
chroot "/host" /usr/bin/docker create -v "${data_dir}:/var/lib/pgsql/data:Z" \
    --name "${NAME}" "${IMAGE}"

# Create and enable systemd unit file for the service
sed -e "s/TEMPLATE/${NAME}/g" "/docker/atomic/"template.service > "/host/etc/systemd/system/${NAME}.service"
chroot "/host" /usr/bin/systemctl enable "/etc/systemd/system/${NAME}.service"
