#!/usr/bin/env bash

cat <<EOF >> /home/vagrant/.bashrc
# Custom PS1
PS1="GIStack: "

# Switch to /vagrant on login
cd /vagrant
EOF

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

echo Installing PostgreSQL and PostGIS...
apt-get install -y postgresql-{,client-,contrib-,server-dev-}9.3 postgresql-9.3-postgis-2.1 > /dev/null
su postgres -c "createuser -s vagrant; createdb -O vagrant vagrant"
su vagrant -c "psql -c '\
CREATE EXTENSION postgis;\
CREATE EXTENSION postgis_topology;\
CREATE EXTENSION fuzzystrmatch;\
CREATE EXTENSION postgis_tiger_geocoder;'" > /dev/null

echo Installing OpenStreetMap and OGR tools...
apt-get install -y osm2pgsql osmctools osmosis gdal-bin > /dev/null

echo Installing GeoServer...
GEOZIP='/var/cache/apt/archives/geoserver.zip'
GEOURL="http://sourceforge.net/projects/geoserver/files/GeoServer/2.6.0/geoserver-2.6.0-war.zip"
if [ ! -f $GEOZIP ]; then
  wget -q -O $GEOZIP $GEOURL
fi
unzip -d /var/lib/tomcat7/webapps/ $GEOZIP

echo "Success! Geoserver available at http://localhost:8080/geoserver"
