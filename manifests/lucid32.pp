#include mini_postgres
include nodejs
include 'apt'

class { "rubybuild":
  ruby_version => "2.2.3",
  ruby_install_dir => "/opt/rubies/"
}



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

  package {"zsh":
    ensure => present,
  }

  package {"sqlite":
  	ensure => present,
  }

  file {"/etc/zsh/zprofile":
    content => "source /usr/local/share/chruby/chruby.sh; source /usr/local/share/chruby/auto.sh",  /*make SURE we source the chruby AND the auto file - might not happen in zsh init */
 }

  /* TODO make me better */
  exec { "install_chruby":
    command => "/bin/bash -c 'cd /tmp && wget -O chruby-0.3.6.tar.gz https://github.com/postmodern/chruby/archive/v0.3.6.tar.gz && tar -xzvf chruby-0.3.6.tar.gz && cd chruby-0.3.6/ && make install'",
    creates =>"/usr/local/share/chruby/chruby.sh",
  }

  file { "/etc/profile.d/chruby.sh":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0755,
    content => "source /usr/local/share/chruby/chruby.sh",
    require => [
          Exec["install_chruby"]
    ]
  }

}


class {
/*  "predeps": stage => pre-rvm; */
  "lucid32": stage => main;
  "project_custom": stage => last;
}

#include lucid32
