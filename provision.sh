#!/bin/bash

#Set the host name 
SRV_NAME="ezlamp-dev.local"

#Set Web root relative to /var/www
WEB_ROOT="public"

#Optionally add certificate files
SSL_CERT="cert.pem"
SSL_CERT_KEY="cert-key.pem"

#Optionally enable redis service, 1 == enabled, 0 == disabled
ENABLE_REDIS=0

#Optinally enable elasticsearch service, 1 == enabled, 0 == disabled
ENABLE_ELASTICSEARCH=0



PHP_VERSION="7.4"

cat <<EOF | sudo tee /etc/apache2/sites-available/ezlamp.conf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    ServerName ${SRV_NAME}
    DocumentRoot "/var/www/${WEB_ROOT}"
    <Directory "/var/www/${WEB_ROOT}">
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all    
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

CERT="/var/www/${SSL_CERT}"
CERT_KEY="/var/www/${SSL_CERT_KEY}"
if [[ -f $CERT ]] && [[ -f $CERT_KEY ]];then

    sudo cp $CERT /etc/apache2/sites-available/$SSL_CERT
    sudo cp $CERT_KEY /etc/apache2/sites-available/$SSL_CERT_KEY    

cat <<EOF | sudo tee -a /etc/apache2/sites-available/ezlamp.conf
<VirtualHost *:443>
    ServerAdmin webmaster@localhost
    ServerName ${SRV_NAME}
    DocumentRoot "/var/www/${WEB_ROOT}"
    <Directory "/var/www/${WEB_ROOT}">
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        allow from all    
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
    
    SSLEngine on
    SSLCertificateFile /etc/apache2/sites-available/$SSL_CERT
    SSLCertificateKeyFile /etc/apache2/sites-available/$SSL_CERT_KEY    
</VirtualHost>
EOF
fi

sudo rm -f /etc/apache2/sites-enabled/*.conf
sudo ln -sf /etc/apache2/sites-available/ezlamp.conf /etc/apache2/sites-enabled/ezlamp.conf
sudo service apache2 restart

if [ $ENABLE_REDIS == 1 ];then
sudo systemctl enable redis-server.service
sudo systemctl start redis-server.service
fi

if [ $ENABLE_ELASTICSEARCH == 1 ];then
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
fi


