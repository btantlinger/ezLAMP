# ezLAMP

A basic preprovisioned dev LAMP box in the spirit of [ScotchBox](https://box.scotch.io/) which includes:

- Ubuntu 16.04.4
- Apache 2.4
- MySQL 5.7
- PHP 7
- composer
- Xdebug
- MailCatcher
- phpMyAdmin
- node & npm
- Gulp, Grunt, Bower, Webpack

## Start up ezLAMP
Assuming that VirtualBox (https://www.virtualbox.org/) and Vagrant (https://www.vagrantup.com/) are already installed on your machine...

1. Clone or download + unzip repository
2. In your terminal go to the directory and type `vagrant up`
3. Enjoy

## Using ezLAMP

After the box starts, you can access it from http://192.168.33.44/ in your browser.  You may also access it from a local domain such as http://ezlamp.local or http://yourdomain.local by setting up any local domains in your hosts file. E.g:

`192.168.33.44 ezlamp.local yourdomain.local`

The document root is in the `public` subdirectory.

#### MailCatcher
Any email your application sends are caught by MailCatcher, which can be accessed from:
http://192.168.33.44:1080

#### MySQL
Connection details for the MySQL database are:
**database:** ezlamp
**user:** root
**password:** 123
phpMyAdmin can be accessed from http://192.168.33.44/phpmyadmin

## Configuration
There's not much to configure with ezLAMP.  Simply edit the Vagrantfile to make any configuration changes you might require.

#### IP Address
You can change the ip of the box by editing the following line in the `Vagrantfile` and replacing 192.168.33.44 with the ip you'd like to use:

`config.vm.network "private_network", ip: "192.168.33.44"`

#### Multiple Domains
You can add additional domains, by adding the following provisioning shell to the Vagrantfile:

```
     config.vm.provision "shell", inline: <<-SHELL

        ## Only thing you probably really care about is right here
        DOMAINS=("site1.local" "site2.local")

        ## Loop through all sites
        for ((i=0; i < ${#DOMAINS[@]}; i++)); do

            ## Current Domain
            DOMAIN=${DOMAINS[$i]}

            echo "Creating directory for $DOMAIN..."
            mkdir -p /var/www/$DOMAIN/public

            echo "Creating vhost config for $DOMAIN..."
            sudo cp /etc/apache2/sites-available/ezlamp.local.conf /etc/apache2/sites-available/$DOMAIN.conf

            echo "Updating vhost config for $DOMAIN..."
            sudo sed -i s,ezlamp.local,$DOMAIN,g /etc/apache2/sites-available/$DOMAIN.conf
            sudo sed -i s,/var/www/public,/var/www/$DOMAIN/public,g /etc/apache2/sites-available/$DOMAIN.conf

            echo "Enabling $DOMAIN. Will probably tell you to restart Apache..."
            sudo a2ensite $DOMAIN.conf

            echo "So let's restart apache..."
            sudo service apache2 restart

        done

    SHELL
```
The above example would add Apache virtual hosts for site1.local and site2.local.  The document roots for these domains would be site1.local/public and site2.local/public respectively.

This example was taken from [scotchbox](https://scotch.io/bar-talk/announcing-scotch-box-2-0-our-dead-simple-vagrant-lamp-stack-improved#provisioning).  The other provisioning examples might work with ezLAMP as well, although, I have not tried.



 
