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

code_folder:
	mkdir -p code
	#if test ! -d code/YOUR_PROJECT; then cd ./code && git clone YOUR_PROJECT_URL; fi
