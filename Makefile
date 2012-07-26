# Supporting dependancies (above this point are "command" dependancies)
modules_folder:
	pwd
	mkdir -p modules
	if test -d modules/mini_postgres; then cd ./modules/mini_postgres && git pull origin master; else cd ./modules && git clone git://github.com/rwilcox/puppet_mini_postgres.git mini_postgres; fi
	if test -d modules/python; then cd ./modules/python && git pull origin master; else cd ./modules && git clone git://github.com/uggedal/puppet-module-python.git python; fi
	if test -d modules/apt; then cd ./modules/apt && git pull origin master; else cd ./modules && git clone git://github.com/puppetlabs/puppetlabs-apt.git apt; fi
	if test -d modules/stdlib; then cd ./modules/stdlib && git pull origin master; else cd ./modules && git clone git://github.com/puppetlabs/puppetlabs-stdlib.git stdlib; fi
	if test -d modules/nodejs; then cd ./modules/nodejs && git pull origin master; else cd ./modules && git clone git://github.com/puppetlabs/puppetlabs-nodejs.git nodejs; fi
