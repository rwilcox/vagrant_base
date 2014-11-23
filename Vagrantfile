Vagrant.configure("2") do |config|
  config.vm.box = "jnj_dev_cell/precise64"     # Ubuntu 12 with Puppet 3.6. Thanks Vagrant Cloud!
  #config.vm.box_url = "http://grahamc.com/vagrant/ubuntu-12.04-omnibus-chef.box"

  config.vm.provider "virtualbox" do |vm|
    vm.memory = 1024
    vm.cpus = 2
  end

  config.vm.provision :shell, :path => "vagrant_tools/use_modern_ruby.sh"  # Above box is set with Ruby 1.8.7 WITH NO RUBYGEMS as default Ruby. Set to sane version.

  config.vm.provision :shell, :inline => "test -d /etc/puppet/modules/rvm || puppet module install maestrodev/rvm"
  # REVIEW: 12-15-2014: Only do this if pull request to add gpg2 is accepted & posted on puppet forge
  # SEE: https://github.com/maestrodev/puppet-rvm/pull/67

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
