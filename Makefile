# Supporting dependancies (above this point are "command" dependancies)
update_code: modules_folder code_folder

run: update_code
        vagrant up

reload: update_code
        vagrant reload

modules_folder:
	pwd
	mkdir -p modules
	if test -d modules/mini_postgres; then cd ./modules/mini_postgres && git pull origin master; else cd ./modules && git clone git://github.com/rwilcox/puppet_mini_postgres.git mini_postgres; fi
	if test -d modules/apt; then cd ./modules/apt && git pull origin master; else cd ./modules && git clone git://github.com/puppetlabs/puppetlabs-apt.git apt; fi
	if test -d modules/stdlib; then cd ./modules/stdlib && git pull origin master; else cd ./modules && git clone git://github.com/puppetlabs/puppetlabs-stdlib.git stdlib; fi
	if test -d modules/nodejs; then cd ./modules/nodejs && git pull origin master; else cd ./modules && git clone git://github.com/puppetlabs/puppetlabs-nodejs.git nodejs; fi
	if test -d modules/rvm; then cd ./modules/rvm && git pull origin rvm_puppet_works_without_installing_rvm; else cd ./modules && git clone git://github.com/rwilcox/puppet-rvm.git rvm && cd rvm && git checkout -t origin/rvm_puppet_works_without_installing_rvm; fi

code_folder:                                                                                                                                                if test ! -d code/sway-timeslips; then cd ./code && git clone https://github.com/greenriver/sway-timeslips.git; fi
	#if test ! -d code/YOUR_PROJECT; then cd ./code && git clone YOUR_GIT_URL; fi
