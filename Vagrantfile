Vagrant.configure("2") do |config|
  config.vm.box = "puppetlabs/ubuntu-12.04-64-puppet"   # Precise

  config.vm.provider "virtualbox" do |vm|
    vm.memory = 1024
    vm.cpus = 2
  end

  puppet_environment = "puppet"  # the name of the directory in this source tree that contains the puppet modules, manifests and environment.config
  #                    ^^^^^ !!!!! if changing me change value in #{folder_formerly_known_as_puppet}/environment.config  !!!!!!

  puppet_environment_path_on_guest = "/etc/puppetlabs/code/environments/#{puppet_environment}"
  module_path_on_guest = "#{puppet_environment_path_on_guest}/modules"

  config.vm.provision :shell, path: "vagrant_tools/remove_puppet_unless_modern.sh"  # this VM (may) have a VERY old Puppet version, install 4.3
  config.vm.provision :shell, path: "vagrant_tools/install_puppet_on_ubuntu.sh"
  config.vm.provision :shell, :path => "vagrant_tools/use_modern_ruby.sh"  # Ubuntu 12 Above box is set with Ruby 1.8.7 WITH NO RUBYGEMS as default Ruby. Set to sane version.

  config.vm.provision :shell, :inline => "test -d #{module_path_on_guest}/ || mkdir #{puppet_environment_path_on_guest}"

  config.vm.provision :shell, :inline => "test -d #{module_path_on_guest}/apt || puppet module install puppetlabs-apt --environment=#{puppet_environment}"
  config.vm.provision :shell, :inline => "test -d #{module_path_on_guest}/nodejs || puppet module install puppetlabs-nodejs --environment=#{puppet_environment}"
  config.vm.provision :shell, :inline => "test -d #{module_path_on_guest}/python || puppet module install stankevich-python --environment=#{puppet_environment}"
  config.vm.provision :shell, :inline => "test -d #{module_path_on_guest}/redis || puppet module install thomasvandoren-redis --environment=#{puppet_environment}"
  config.vm.provision :shell, :inline => "test -d #{module_path_on_guest}/rubybuild || puppet module install benben-rubybuild --environment=#{puppet_environment}"

  config.vm.provision :puppet do |puppet|
    if ENV.key?('PUPPET_OPTS')  # See http://stackoverflow.com/a/27540417/224334
      puppet.options = ENV['PUPPET_OPTS'].split(' ')
    end
    if ENV["PUPPET_VERBOSE"] then puppet.options = "--verbose --debug" end
    
    puppet.environment = "puppet"
    puppet.environment_path = "./"
    
    puppet.manifests_path   = "puppet/manifests"
    
    puppet.manifest_file = "lucid32.pp"
    puppet.facter        = {
  		project_name: "ENGLISH NAME Of PROJECT",             # EDIT THIS LINE
  	}
  end

  config.vm.synced_folder "code", "/projects"   # EDIT/DUPLICATE THIS LINE for additional shared folders

  config.vm.network :forwarded_port, guest: 22, host: 2223, auto_correct: true, id: "ssh" 
  config.vm.network :forwarded_port, guest: 3000, host: 3000

end
