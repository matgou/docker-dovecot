#!/bin/sh

if [ -z $MYSQL_DATABASE ]; then
	MYSQL_DATABASE="postfix"
fi

if [ -z $MYSQL_USER ]; then
	MYSQL_USER="root"
fi

if [ -z $MYSQL_PASSWORD ]; then
	MYSQL_PASSWORD="root"
fi

if [ -z $MYSQL_HOST ]; then
	MYSQL_HOST="database"
fi

if [ -z $MYSQL_PORT ]; then
	MYSQL_PORT=3306
fi

if [ -z $SSL_DIR ];
then
	echo "You must specify SSL DIRECTORY"
	exit 255
fi

fic_lst=$( ls /etc/dovecot/dovecot-sql.conf /etc/dovecot/conf.d/10-ssl.conf )
for fic in $fic_lst;
do
	sed -i "s/@@MYSQL_DATABASE@@/$MYSQL_DATABASE/g" $fic
	sed -i "s/@@MYSQL_USER@@/$MYSQL_USER/g" $fic
	sed -i "s/@@MYSQL_HOST@@/$MYSQL_HOST/g" $fic
	sed -i "s/@@MYSQL_PASSWORD@@/$MYSQL_PASSWORD/g" $fic
	sed -i "s/@@MYSQL_PORT@@/$MYSQL_PORT/g" $fic
	sed -i "s:@@SSL_DIR@@:$SSL_DIR:g" $fic
done

svscan /etc/service
