Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # config.vm.box = "ubuntu-11.10-server-i386"
  #config.vm.box_url = "http://wilcoxd.com/oss/ubuntu-11.10-server-i386"
  config.vm.box = "lucid32_puppet_2.7.11"
  config.vm.box_url = "http://www.wilcoxd.com/oss/lucid32_puppet_2.7.11.box"

  config.vm.customize do |vm|
    vm.memory_size = 1024   # 1 GB of memory
    vm.cpu_count = 3        # yay multiple cores, and an 8 core host
  end

  config.vm.provision :puppet,
  	:module_path => "modules",
  	:manifest_file => "lucid32.pp"



  # EDIT LINES BELOW THIS
  # ##########################################################

  # CHANGE ME: new VMs need a seperate path
  # The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  config.vm.share_folder "project_data", "/projects", "code"
  config.vm.share_folder "mysql_data", 	"/usr/local/mysql/data", "mysql"
  config.vm.forward_port(22, 2223)
  config.vm.forward_port(3000, 3031)

end
