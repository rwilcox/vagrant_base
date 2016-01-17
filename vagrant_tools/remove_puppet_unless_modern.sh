#!/usr/bin/env bash
#
# This removes ancient Puppet versions on the VM - if there IS any ancient
# version on it - so we can install the latest (Puppet 4.3).
#
# It is meant to be run as part of a provisioning run by Vagrant
# so it must ONLY delete old versions (not current versions other stages have installed)
#


if [[ -x /opt/puppetlabs/puppet/bin/puppet ]]; then
  INSTALLED_PUPPET_VERSION=$(/opt/puppetlabs/puppet/bin/puppet --version | xargs)
fi

echo "Currently installed version: $INSTALLED_PUPPET_VERSION"

if [[ $INSTALLED_PUPPET_VERSION && $INSTALLED_PUPPET_VERSION != 4.3* ]] ; then
  apt-get remove -y puppet=$INSTALLED_PUPPET_VERSION puppet-common=$INSTALLED_PUPPET_VERSION
  echo "Removed old Puppet version: $INSTALLED_PUPPET_VERSION"
fi
