Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu12_puppet_chef"
  config.vm.box_url = "http://grahamc.com/vagrant/ubuntu-12.04-omnibus-chef.box"

  #config.vm.customize do |vm|
  #  vm.memory_size = 1024
  #  vm.cpu_count = 2
  #end

  config.vm.provision :shell, :inline => "test -d /etc/puppet/modules/rvm || puppet module install maestrodev/rvm"
  config.vm.provision :shell, :inline => "test -d /etc/puppet/modules/apt || puppet module install puppetlabs-apt"
  config.vm.provision :shell, :inline => "test -d /etc/puppet/modules/nodejs || puppet module install puppetlabs-nodejs"
  config.vm.provision :shell, :inline => "test -d /etc/puppet/modules/python || puppet module install stankevich-python"
  config.vm.provision :shell, :inline => "test -d /etc/puppet/modules/redis || puppet module install thomasvandoren-redis"

  config.vm.provision :puppet do |puppet|

    puppet.module_path   = "modules"
    puppet.manifest_file = "lucid32.pp"
    puppet.facter        = {
  		project_name: "ENGLISH NAME Of PROJECT",             # EDIT THIS LINE
  		rvm_name:     "RVM_GEMSET_NAME_TO_CREATE"              # EDIT THIS LINE
  	}
  end

  config.vm.synced_folder "code", "/projects"   # EDIT/DUPLICATE THIS LINE for additional shared folders

  config.vm.network :forwarded_port, guest: 22, host: 2223   # EDIT/DUPLIACTE THESE LINES FOR ADDITIONAL PORTS
  config.vm.network :forwarded_port, guest: 3000, host: 3000

end
