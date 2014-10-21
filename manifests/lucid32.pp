#include mini_postgres
include rvm
include nodejs
include 'apt'

# http://groups.google.com/group/puppet-users/browse_thread/thread/c60e8ae314ae687b
Exec {
    path => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"],
}

apt::ppa { 'ppa:chris-lea/node.js':
  before => Anchor['nodejs::repo'],
}

  exec {"apt-get update":
    command => "/usr/bin/apt-get update",
    user => "root",
    logoutput => on_failure,
     before => Package['python-software-properties']
  }

stage { "first": before => Stage[main] }
stage { "last": require => Stage[main] }


class { 'redis':
  version => "2.8.17",
}

class lucid32 {

  group { "puppet":
    ensure => present,
  }

  package{"libaio-dev":
    ensure => present,
    /* before => Package[""]  */
   /* this package was in the predeps stage, but not sure why...
      maybe I needed it to be installed for something else? */
  }

  package { "screen":
    ensure => present,
  }


#  postgresql::user {"vagrant":
#    ensure => present,
#    superuser => true,
#  }

  package {"coffee-script":
    ensure => present,
    provider => 'npm',
    require => Class["Nodejs"]
  }

  package {"less":
    ensure => present,
    provider => 'npm',
    require => Class["Nodejs"]
  }

  package {"vim":
  	ensure => present,
  }

  package {["python-setuptools", "python-dev", "python-pip"]:
  	ensure => present,
  }

  python::pip {"mercurial":
  	ensure => present,
  	require => Package['python-pip']
  }

  package{"git":
    ensure => present
  }
}

class project_custom {

/* Include files, compilers etc that this project requires below */

  user { "vagrant":
    ensure => present,
    shell  => "/bin/zsh",
    require => Package["zsh"]  /* I like zsh, thank you very much */
  }

  file { '/etc/motd':
    content => "*** Welcome to the ${project_name} box ***\n"
  }

  rvm::system_user { vagrant: ;}


  rvm_system_ruby {
    'ruby-2.0.0-p247':
      ensure => 'present',
      default_use => false,
  }


  rvm_gemset {
  "ruby-2.0.0-p247@${rvm_name}":
    ensure => present,
    require => Rvm_system_ruby['ruby-2.0.0-p247'];
  }

  rvm_gem {
    'bundler':
      name => "bundler",
      ruby_version => 'ruby-2.0.0-p247',
      ensure => latest,
      require => Rvm_gemset["ruby-2.0.0-p247@${rvm_name}"];
  }

  package {"zsh":
    ensure => present,
  }

  package {"sqlite":
  	ensure => present,
  }

  file {"/etc/zsh/zprofile":
    content => "source /etc/profile.d/rvm.sh",  /*make SURE we source the rvm file - might not happen in zsh init */
    require => Rvm_system_ruby["ruby-2.0.0-p247"]
 }

}


class {
/*  "predeps": stage => pre-rvm; */
  "lucid32": stage => main;
  "project_custom": stage => last;
}

#include lucid32
