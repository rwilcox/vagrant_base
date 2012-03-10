Why Me?
==========================================================

Provides a template Vagrant project that will boot up a good working Vagrant box, with good defaults that you can also customize. The goal here is minimal turst: take a known good base box and provision it into usefulness.

Convention over configuration
=========================================================

This Vagrant file and setup assumes a number of things:

  1. You want a 64bit VM
  2. You want to use Puppet

What this base box pulls in
==========================================================

  1. Git
  2. Mercurial
  3. GNU Screen
  4. Postgresql
  5. SQLite
  6. Python modules: pip, virtualenv
  7. RVM


Puppet Modules Required
===========================================================

  1. [Python Puppet Module](https://github.com/garthrk/python-module-for-puppet)
  2. [Mini-Postgres Puppet Module](https://github.com/rwilcox/puppet_mini_postgres)
  3. [Puppet Module for RVM](https://github.com/blt04/puppet-rvm)

The Vagrant file assumes your Puppet modules live in /home/vagrant/puppet_modules. You might need to fix this path on your system (I'm doing this on Linux, not OS X)

Steps to fire up a new VM
===========================================================

  1. Clone appropriate Git Vagrant repo
  2. Edit port forwarding, shared folders
  3. Open manifests/lucid32.pp, search for CHANGE ME. Change specified items
  4. vagrant up

To use this box as a basebox for other VMs
=========================================================

  1. vagrant package
  2. vagrant box add NAME package.box

What To Do with A New VM
==========================================================

  1. Write down port numbers on host machine that map
  2. Tell user to change password
  3. All project work should happen in /projects (TODO: symlink ~/projects to this?)
  4. Change your mysql root password
  5. Install rvm

