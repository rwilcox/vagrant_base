include mini_postgres
include rvm

include nodejs
# NodeJS support provided by https://github.com/puppetlabs/puppetlabs-nodejs
# it also brings in the puppet standard library and APT puppet support

# http://groups.google.com/group/puppet-users/browse_thread/thread/c60e8ae314ae687b
Exec {
    path => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"],
}

stage { "pre-rvm": before => Stage[rvm-install] }
stage { "first": before => Stage[main] }
stage { "last": require => Stage[main] }

class predeps {
  /* these items will get installed before Puppet installs RVM.
     So we can safely do things like make sure the latest packages
     Are avail, and remove any user based RVMs we might have on the base box
  */
  package { "python-dev":
    ensure => present,
  }

  package {"libevent-dev":
    ensure => present,
  }

  exec {"apt-get update":
    command => "/usr/bin/apt-get update",
    user => "root",
    logoutput => on_failure,
  }


  group { "puppet":
    ensure => present,
  }

  file {"vagrant_rvmrc":
    path => "/home/vagrant/.rvmrc",
    ensure => absent,
    before => Exec["vagrant_rvm"],
  }

  exec {"vagrant_rvm":
     /* use rm -rf here, even though it is considered dirty - File resource
        would check to see if included files are needed by later Puppet stages,
        which (given number of files in .rvm) will take forever.

       -f gives us the nice side effect of NOT returning an error code
       if the directory has already been deleted (by previous Puppet runs!)
     */
     command => "rm -rf /home/vagrant/.rvm",
     user => root,
     logoutput => on_failure
  }
  /* I believe you could also do:
        before => Exec["Stage[rvm-install]/Exec[system-rvm"] to specify an inter-class dependancy
        However, using run stages to make sure the entire system is sane before even starting
        to do work seems the preferable option. WD-rpw 03-10-2012
  */

}

class lucid32 {
  apt::source {"debian_backports":
    location          => "http://us.archive.ubuntu.com/ubuntu/",
    release           => "lucid-backports",
    repos             => "main restricted universe multiverse",
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

  package {"libreadline5-dev":
    ensure => present,
  }

  # unison is picky about client/server versions, FORCE this version because it's what I can get. WD-rpw 07-26-2012
  apt::force {"unison":
    release => "lucid-backports",
    version => "2.32.52",
    #ensure => present,
    require => Apt::Source["debian_backports"]
  }

  postgresql::user {"vagrant":
    ensure => present,
    superuser => true,
  }

  package {"coffee-script":
    ensure => present,
    provider => 'npm',
  }

  package {"less":
    ensure => present,
    provider => 'npm',
  }

}

class project_custom {

/* CHANGE ME:
  1. ADD PACKAGES SPECIFIC TO YOUR NEEDS
  2. change PROJECT_NAME rvm_gemset settings to proper gemset to create */
*/

  user { "vagrant":
    ensure => present,
    shell  => "/bin/zsh",
    require => Package["zsh"]  /* I like zsh, thank you very much */
  }

  file { '/etc/motd':
    content => "*** Welcome to the PROJECT_NAME box ***\n"
  }

  rvm::system_user { vagrant: ;}

/*
	NOTE: the ruby configurations below pull in openssl as the openssl on the OS
	may be too old to support Rubygems 2.0 + HTTPS properly.

	And by "not support Rubygems 2.0 + HTTPS properly" I mean:

	> Bundler::Fetcher::CertificateFailureError: Could not verify the SSL certificate for https://rubygems.org/
	or
	> Could not verify the SSL certificate for https://rubygems.org/.

*/
  rvm_system_ruby {
    'ruby-1.9.2-p290':
      ensure => 'present',
      default_use => false,
      install_opts => "--with-openssl-dir=$rvm_path/usr",
      require => "ruby-1.8.7-p357";
  }

  rvm_system_ruby {
    'ruby-1.8.7-p357':
      ensure => 'present',
      pkg => "openssl", /* THIS LINE requires the puppet-rvm from the makefile OR <https://github.com/blt04/puppet-rvm/pull/68> to be merged into puppet-rvm master */
      install_opts => "--with-openssl-dir=$rvm_path/usr",
      default_use => false;
  }

  rvm_gemset {
  "ruby-1.9.2-p290@PROJECT_NAME":
    ensure => present,
    require => Rvm_system_ruby['ruby-1.9.2-p290'];
  }

  rvm_gem {
    'bundler':
      name => "bundler",
      ruby_version => 'ruby-1.9.2-p290',
      ensure => latest,
      require => Rvm_gemset['ruby-1.9.2-p290@PROJECT_NAME'];
  }

  package {"zsh":
    ensure => present,
  }

  file {"/etc/zsh/zprofile":
    content => "source /etc/profile.d/rvm.sh",  /*make SURE we source the rvm file - might not happen in zsh init */
    require => Rvm_system_ruby["ruby-1.9.2"]
 }

}


class {
  "predeps": stage => pre-rvm;
  "lucid32": stage => main;
  "python": stage => main;
  "project_custom": stage => last;
}

#include lucid32
