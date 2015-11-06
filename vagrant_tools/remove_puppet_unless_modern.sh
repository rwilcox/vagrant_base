#!/usr/bin/env bash
#
# This removes ancient Puppet versions on the VM - if there IS any ancient
# version on it - so we can install the latest.
#
# It is meant to be run as part of a provisioning run by Vagrant
# so it must ONLY delete old versions (not current versions other stages have installed)
#
# It assumes that we're targeting Puppet 3.7 (modern as of Feb 2015...)

INSTALLED_PUPPET_VERSION=$(apt-cache policy puppet | grep "Installed: " | cut -d ":" -f 2 | xargs)
echo "Currently installed version: $INSTALLED_PUPPET_VERSION"

if [[ $INSTALLED_PUPPET_VERSION != 3.7* ]] ; then
  apt-get remove -y puppet=$INSTALLED_PUPPET_VERSION puppet-common=$INSTALLED_PUPPET_VERSION
  echo "Removed old Puppet version: $INSTALLED_PUPPET_VERSION"
fi
