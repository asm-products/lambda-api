#!/bin/bash
echo "------------ Starting provisioning script ------------------------------"
# include config variables
. /vagrant/devops/config

sudo apt-get update && sudo apt-get -y upgrade

echo "------------ NTP (time sync) -------------------------------------------"
sudo apt-get install ntp
sudo cp /vagrant/devops/ntp-skeleton.conf /etc/ntp.conf
sudo /etc/init.d/ntp restart

echo "------------ Git & Node ------------------------------------------------"
sudo apt-get install -y git nodejs
sudo update-alternatives --install /usr/bin/node nodejs /usr/bin/nodejs 100
sudo apt-get install -y npm

echo "------------ MySQL -----------------------------------------------------"
sudo apt-get install -y postgresql postgresql-contrib libpq-dev
sudo -u postgres createuser --superuser $DBUSER
sudo -u postgres createdb -O vagrant $DBNAME
sudo -u postgres createdb -O vagrant $DBTESTNAME

echo "------------ Install RVM -----------------------------------------------"
sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
curl -sSL https://get.rvm.io | sudo bash -s stable --ruby=2.1.2

echo "------------ Source RVM ------------------------------------------------"
source /usr/local/rvm/scripts/rvm

echo "------------ Install Dependencies --------------------------------------"
sudo apt-get install -y apache2 apache2-dev libcurl4-gnutls-dev libapache2-svn libapache-dbi-perl libapache2-mod-perl2 libdbd-pg-perl libauthen-simple-ldap-perl openssl

sudo dpkg --configure -a

echo "------------ Run a2enmod -----------------------------------------------"
sudo a2enmod ssl perl dav dav_svn dav_fs rewrite

echo "------------ Add user to rvm group -------------------------------------"
sudo adduser vagrant rvm

echo "------------ Start new shell -------------------------------------------"
su - vagrant

echo "------------ Install Bundler gem ---------------------------------------"
export rvmsudo_secure_path=1
rvmsudo gem install bundler

echo "------------ Install Passenger gem -------------------------------------"
export rvmsudo_secure_path=1
rvmsudo gem install passenger --version 4.0.53

echo "------------ Run passenger-install-apache2-module ----------------------"
rvmsudo passenger-install-apache2-module

echo "------------ Update apache config --------------------------------------"
sudo mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.bak
sudo cp /vagrant/devops/apache-skeleton.conf /etc/apache2/sites-available/000-default.conf

echo "------------ Update passenger config -----------------------------------"
sudo cp /vagrant/devops/passenger-skeleton.conf /etc/apache2/conf-available/passenger.conf

echo "------------ Load passenger config and restart apache ------------------"
sudo a2enconf passenger
sudo service apache2 restart

echo "------------ Install project gems --------------------------------------"
cd /vagrant
bundle install

echo "------------ Setup DB --------------------------------------------------"
rake db:setup RAILS_ENV=development
rake db:migrate
