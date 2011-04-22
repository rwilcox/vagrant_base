Why Me?
==========================================================

Provides a template Vagrant project that will boot up a good working Vagrant box, with good defaults that you can also customize. The goal here is minimal turst: take a known good base box and provision it into usefulness.

Convention over configuration
=========================================================

This Vagrant file and setup assumes a number of things
  1. You want a 64bit VM
  2. You want to use Puppet


Steps to fire up a new VM
===========================================================

  1. Clone appropriate Git Vagrant repo
  2. Edit port forwarding, shared folders
  3. vagrant up

What To Do with A New VM
==========================================================

  1. Write down port numbers on host machine that map
  2. Tell user to change password
  3. All project work should happen in /projects (TODO: symlink ~/projects to this?)

