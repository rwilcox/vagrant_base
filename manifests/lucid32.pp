stage { "first": before => Stage[main] }
stage { "last": require => Stage[main] }

class predeps {

  package { "python-dev":
    ensure => present,
  }

  exec {"apt-get update":
    command => "/usr/bin/apt-get update",
    user => "root",
    logoutput => on_failure,
  }
}

class lucid32 {
  package { "screen":
    ensure => present,
  }

  package { "git-core":
    ensure => present,
  }

  package { "sqlite3":
    ensure => present,
  }

  package { "libsqlite3-dev":
    ensure => present,
  }

  package { "curl":
    ensure => present,
  }

  package {"libssl-dev":
    ensure => present,
  }

  package {"libreadline5-dev":
    ensure => present,
  }

  # TODO: maybe get this set up? Now we do have a manual
  # step of getting this up, but in addition to doing the
  # command you also have to add it to your profile file
  # (which might be Bash, but maybe not. I like zsh, for
  # example. WD-rpw 04-29-2011
  #exec { "rvm installer":
  #  cwd => "/home/vagrant/",
  #  creates => "/home/vagrant/.rvm",
  #  require => [ Package["git-core"], Package['curl'] ],
  #  command => "/bin/bash < <(/usr/bin/curl -s https://rvm.beginrescueend.com/install/rvm)",
  #  user => "vagrant"

  # } 
}

class pythonextras {
  pymod {"mercurial":
     name => "mercurial"
  }

  pymod {"pip":
    name => "pip"
  }

  pymod {"virtualenv":
    name => "virtualenv"
  }
}

class {
  "predeps": stage => first;
  "lucid32": stage => main;
  "python": stage => main;
  "pythonextras": stage => main;
  "mysql": stage => main;
}
#include lucid32
#include python 
# python support provided by https://github.com/garthrk/python-module-for-puppet
# used to let us talk to easy_install and install Python modules
#include pythonextras
