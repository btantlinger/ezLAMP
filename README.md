# ezMage

A basic preprovisioned LAMP development environment

- Ubuntu 20.04
- Apache
- redis
- elasticsearch 7
- MySQL 8
- PHP 7.4
- composer
- Xdebug
- MailHog
- node & npm
- Gulp, Grunt
- phpMyAdmin

## Start up ezLAMP
Assuming that VirtualBox (https://www.virtualbox.org/) and Vagrant (https://www.vagrantup.com/) are already installed on your machine...

1. Clone or download + unzip repository
2. In your terminal go to the directory and type `vagrant up`
3. Enjoy

## Using ezLAMP

The default configuration of the box uses the ip 192.168.33.44 and domain ezlamp-dev.local.  The webroot, domain name, and various other options can be changed in the provision.sh shell file.


You should make an entry in your /etc/hosts file for the domain. E.g

`192.168.33.44 ezlamp-dev.local`


#### MailHog
Any emails your application sends are caught by MailHog, which can be accessed from:
http://192.168.33.44:8025

#### MySQL
Connection details for the MySQL database are:

**database:** ezlamp
**user:** admin
**password:** 123

#### phpMyAdmin

http://192.168.33.44/phpmyadmin

**user:** root
**password:** 123


#### IP Address
You can change the ip of the box by editing the following line in the `Vagrantfile` and replacing 192.168.33.23 with the ip you'd like to use:

`config.vm.network "private_network", ip: "192.168.33.23"`
