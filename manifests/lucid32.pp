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
