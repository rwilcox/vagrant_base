#!/usr/bin/env bash

# No, Ruby 1.9.1 isn't really a modern Ruby, but it's what's installed with Ubuntu 12. WD-rpw 11-16-2014
# (and by default Ubuntu 12 uses 1.8.7. SUCH OLD. VERY ANCIENT. MUCH DEPRECATED.)
#
# It's advised to use Puppet to upgrade to a modern version, but in order to do that we
# need to make this half step (depending on box config. Ruby 1.9.x series ships
# with Rubygems as part of standard Ruby install (I think???) where as Ruby 1.8.7 doesn't)
if [ "$(ruby --version | grep 'ruby 1.8.7')" ]
then
	update-alternatives --set ruby /usr/bin/ruby1.9.1
fi;
