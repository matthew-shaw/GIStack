#!/usr/bin/env bash

echo "export PS1='GIStack: '" >> /home/vagrant/.bashrc

echo Update repositories and get upgrades...
apt-get update > /dev/null

echo Installing Git...
apt-get install -y git > /dev/null

echo Installing NGINX...
apt-get install -y nginx > /dev/null
rm -rf /usr/share/nginx/html
[ ! -d /vagrant/html ] && /vagrant/html
ln -fs /vagrant/html /usr/share/nginx/html

echo Installing Tomcat 7...
apt-get install -y tomcat7 > /dev/null
rm -rf /var/lib/tomcat7/webapps
[ ! -d /vagrant/war ] && /vagrant/war
ln -fs /vagrant/war /var/lib/tomcat7/webapps

echo Installing PostgreSQL and PostGIS...
apt-get install -y postgresql-{,client-,contrib-,server-dev-}9.3 postgresql-9.3-postgis-2.1 > /dev/null
su postgres -c "createuser -s vagrant; createdb -O vagrant vagrant"
su vagrant -c "psql -c '\
CREATE EXTENSION postgis;\
CREATE EXTENSION postgis_topology;\
CREATE EXTENSION fuzzystrmatch;\
CREATE EXTENSION postgis_tiger_geocoder;'" > /dev/null

echo Installing OpenStreetMap tools...
apt-get install -y osm2pgsql osmctools osmosis > /dev/null
