#!/bin/sh -e

# Edit the following to change the name of the database user that will be created:
APP_DB_USER=postgres
APP_DB_PASS=vagrant

# Edit the following to change the name of the database that is created (defaults to the user name)
APP_DB_NAME=$APP_DB_USER

# Edit the following to change the version of PostgreSQL that is installed
PG_VERSION=9.3

###########################################################
# Changes below this line are probably not necessary
###########################################################
print_db_usage () {
  echo "Your PostgreSQL database has been setup and can be accessed on your local machine on the forwarded port (default: 15432)"
  echo "  Host: localhost"
  echo "  Port: 15432"
  echo "  Database: $APP_DB_NAME"
  echo "  Username: $APP_DB_USER"
  echo "  Password: $APP_DB_PASS"
  echo ""
  echo "Admin access to postgres user via VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo ""
  echo "psql access to app database user via VM:"
  echo "  vagrant ssh"
  echo "  sudo su - postgres"
  echo "  PGUSER=$APP_DB_USER PGPASSWORD=$APP_DB_PASS psql -h localhost $APP_DB_NAME"
  echo ""
  echo "Env variable for application development:"
  echo "  DATABASE_URL=postgresql://$APP_DB_USER:$APP_DB_PASS@localhost:15432/$APP_DB_NAME"
  echo ""
  echo "Local command to access the database via psql:"
  echo "  PGUSER=$APP_DB_USER PGPASSWORD=$APP_DB_PASS psql -h localhost -p 15432 $APP_DB_NAME"
}

export DEBIAN_FRONTEND=noninteractive

PROVISIONED_ON=/etc/vm_provision_on_timestamp
if [ -f "$PROVISIONED_ON" ]
then
  echo "VM was already provisioned at: $(cat $PROVISIONED_ON)"
  echo "To run system updates manually login via 'vagrant ssh' and run 'apt-get update && apt-get upgrade'"
  echo "or remove $PROVISIONED_ON"
  print_db_usage
  exit
fi

#PG_REPO_APT_SOURCE=/etc/apt/sources.list.d/pgdg.list
#if [ ! -f "$PG_REPO_APT_SOURCE" ]
#then
  # Add PG apt repo:
  #echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > "$PG_REPO_APT_SOURCE"

  # Add PGDG repo key:
  #wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
#fi

# Update package list and upgrade all packages
apt-get update
#apt-get -y upgrade
sudo apt-get -y -q install wget zip gcc tar gdebi-core krb5-locales \
						libasn1-8-heimdal libedit2 libgssapi-krb5-2 libgssapi3-heimdal \
						libhcrypto4-heimdal libheimbase1-heimdal libk5crypto3 \
						libkeyutils1 libkrb5-26-heimdal libkrb5-3 libkrb5support0 \
						libldap-2.4-2 libpq5 libroken18-heimdal libsasl2-2 libsasl2-modules \
						libsasl2-modules-db libwind0-heimdal ssl-cert xml-core \
						libxml2 libossp-uuid16 libxslt1.1 \
						curl libssl0.9.8 libossp-uuid16 libxslt1.1 libicu52 libt1-5 t1utils imagemagick  unixodbc texlive-base libgfs-1.3-2

wget -q --continue -P /vagrant/distr/ http://launchpadlibrarian.net/153428081/libicu48_4.8.1.1-12ubuntu2_amd64.deb && sudo dpkg -i /vagrant/distr/libicu48_4.8.1.1-12ubuntu2_amd64.deb

sudo echo "kernel.shmmax=1073741824" >> /etc/sysctl.conf
sudo sysctl -p 

sudo mkdir -p /vagrant/distr/posgresql/
for a in `ls -1 /vagrant/distr/postgr*.tar.bz2`; do tar xvf $a -C /vagrant/distr/posgresql/; done

sudo dpkg -i /vagrant/distr/posgresql/libpq*.deb 
#sudo apt-get install -f -y
sudo dpkg -i /vagrant/distr/posgresql/postgresql-client-common*.deb
sudo dpkg -i /vagrant/distr/posgresql/postgresql-common*.deb
sudo dpkg -i /vagrant/distr/posgresql/postgresql-client*.deb
sudo dpkg -i /vagrant/distr/posgresql/postgresql-9.3*.deb
sudo dpkg -i /vagrant/distr/posgresql/postgresql-contrib*.deb
sudo dpkg -i /vagrant/distr/posgresql/postgresql-server*.deb


#sudo dpkg -i /vagrant/distr/posgresql/*.deb

echo "libpq5" hold | dpkg --set-selections
echo "postgresql-9.3" hold | dpkg --set-selections
echo "postgresql-client-9.3" hold | dpkg --set-selections
echo "postgresql-contrib-9.3" hold | dpkg --set-selections

sudo apt-get install -f -y
export LANG=ru_RU.UTF-8
sudo -E pg_dropcluster --stop $PG_VERSION main
sudo -E pg_createcluster --locale ru_RU.UTF-8 --lc-collate=ru_RU.UTF-8 --lc-ctype=ru_RU.UTF-8 --encoding=UTF8 --start $PG_VERSION main

#apt-get -y install "postgresql-$PG_VERSION" "postgresql-contrib-$PG_VERSION"

PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
PG_DIR="/var/lib/postgresql/$PG_VERSION/main"

# Edit postgresql.conf to change listen address to '*':
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"
sed -i "s/fsync = on/fsync = off/" "$PG_CONF"

echo "# Кодировка
lc_messages = 'ru_RU.UTF-8'
lc_monetary = 'ru_RU.UTF-8'
lc_numeric = 'ru_RU.UTF-8'
lc_time = 'ru_RU.UTF-8'
# Дефолтовая конфигурация для текстовго поиска
default_text_search_config = 'pg_catalog.russian'
default_with_oids = on
escape_string_warning = off
#stats_row_level = off
# end of file" >> "$PG_CONF"


# Append to pg_hba.conf to add password auth:
echo "host    all             all             all                     md5" >> "$PG_HBA"

# Explicitly set default client_encoding
echo "client_encoding = utf8" >> "$PG_CONF"



# Restart so that all new config is loaded:
service postgresql restart

#if ["$APP_DB_USER" = 'postgres']; then
	echo "update"
	cat << EOF | su - postgres -c psql
	-- Alter the database user:
	ALTER USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';
	
EOF
#else
#	echo "Create"
#	cat << EOF | su - postgres -c psql
#	-- Create the database user:
#	CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';
#
#	-- Create the database:
#	CREATE DATABASE $APP_DB_NAME WITH OWNER=$APP_DB_USER
 #                                 LC_COLLATE='ru_RU.utf8'
  #                                LC_CTYPE='ru_RU.utf8'
#                                  ENCODING='UTF8'
#                                  TEMPLATE=template0;
#EOF
#fi;

# Tag the provision time:
date > "$PROVISIONED_ON"

echo "Successfully created PostgreSQL dev virtual machine."
echo ""
print_db_usage