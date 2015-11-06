Vagrant.configure("2") do |config|
  config.vm.box = "puppetlabs/ubuntu-12.04-64-puppet"   # Precise

  config.vm.provider "virtualbox" do |vm|
    vm.memory = 1024
    vm.cpus = 2
  end


  config.vm.provision :shell, :inline => "test -d /etc/puppet/modules/rvm || puppet module install maestrodev/rvm"
  # REVIEW: 12-15-2014: Only do this if pull request to add gpg2 is accepted & posted on puppet forge
  # SEE: https://github.com/maestrodev/puppet-rvm/pull/67
  config.vm.provision :shell, path: "vagrant_tools/remove_puppet_unless_modern.sh"  # this VM has a VERY old Puppet version, install 3.7+
  config.vm.provision :shell, path: "vagrant_tools/install_puppet_on_ubuntu.sh"
  config.vm.provision :shell, :path => "vagrant_tools/use_modern_ruby.sh"  # Ubuntu 12 Above box is set with Ruby 1.8.7 WITH NO RUBYGEMS as default Ruby. Set to sane version.

  config.vm.provision :shell, :inline => "test -d /etc/puppet/modules/apt || puppet module install puppetlabs-apt"
  config.vm.provision :shell, :inline => "test -d /etc/puppet/modules/nodejs || puppet module install puppetlabs-nodejs"
  config.vm.provision :shell, :inline => "test -d /etc/puppet/modules/python || puppet module install stankevich-python"
  config.vm.provision :shell, :inline => "test -d /etc/puppet/modules/redis || puppet module install thomasvandoren-redis"

  config.vm.provision :puppet do |puppet|
    if ENV.key?('PUPPET_OPTS')  # See http://stackoverflow.com/a/27540417/224334
      puppet.options = ENV['PUPPET_OPTS'].split(' ')
    end

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
