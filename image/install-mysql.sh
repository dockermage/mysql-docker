#!/bin/bash
set -e
source /build/buildconfig
set -x

apt-get update
$minimal_apt_get_install perl curl

groupadd -r mysql && useradd -r -g mysql mysql

cd /tmp
curl -SL "http://dev.mysql.com/get/mysql-apt-config_0.2.1-1debian7_all.deb" -o mysql-apt-config.deb
echo "mysql-server-5.6 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.6 mysql-server/root_password_again password root" | debconf-set-selections
dpkg -i mysql-apt-config.deb && rm -f mysql-apt-config.deb

apt-get update && $minimal_apt_get_install mysql-server mysql-client

cp /build-mysql/config/my.cnf /etc/mysql/my.cnf
cp /build-mysql/config/mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf

# runit
mkdir /etc/service/mysql
cp /build-mysql/runit/mysql.sh /etc/service/mysql/run

# clean up
apt-get purge -y --auto-remove curl