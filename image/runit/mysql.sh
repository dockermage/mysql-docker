#!/bin/sh
#see http://smarden.org/runit1/runscripts.html#mysql

trap "mysqladmin shutdown" 0
trap 'exit 2' 1 2 3 15

exec mysqld_safe & wait >> /var/log/mysql/mysql.log