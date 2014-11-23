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
  7. RVM


Puppet Modules Pulled in by vagrant provision
===========================================================

Vagrant's provisioning tools pulls in various Puppet modules used by the manifest. Here's a list:

  1. [NodeJS Puppet Module](https://github.com/puppetlabs/puppetlabs-nodejs)
  2. [Puppet standard library](https://github.com/puppetlabs/puppetlabs-stdlib)
  3. [Puppet APT library](https://github.com/puppetlabs/puppetlabs-apt)
  2. [Mini-Postgres Puppet Module](https://github.com/rwilcox/puppet_mini_postgres)
  3. [Puppet Module for RVM](https://github.com/blt04/puppet-rvm)

Steps to fire up a new VM
===========================================================

  1. Clone appropriate Git Vagrant repo
  2. Edit port forwarding, shared folders
  3. Open manifests/lucid32.pp, search for CHANGE ME. Change specified items
  4. `make modules_folder`
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
  
TODOs
=====================

  - [ ] Use Puppetfile to manage dependancies, have VM shell provisioner fire off puppet-librarian to d/l them all?
  - [X] Move to Ubuntu 12 LTS, not Ubuntu 10 Lucid LTS
  - [X] simple postgress doesn't work under Ubuntu 12. Fix or replace.
  - [X] Fix VagrantFile to use new v2 DSL

