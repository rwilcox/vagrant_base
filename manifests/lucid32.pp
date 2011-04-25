class lucid32 {
  package { "screen":
    ensure => present,
  }

  package { "git-core":
    ensure => present,
  }

  package { "python-dev":
    ensure => present,
  }

}

class pythonextras {
  pymod {"mercurial":
     name => "mercurial"
  }

}

include lucid32
include python
include pythonextras
