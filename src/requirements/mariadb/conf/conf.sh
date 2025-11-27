#!/bin/sh

if ! [ -d "$SQL_DB" ]
then
	mysql_install_db --user=mysql --datadir=/var/lib/mysql

	TMPFILE=$(mktemp)

	cat <<EOF > $TMPFILE
CREATE DATABASE IF NOT EXISTS $SQL_DB;
CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASS';
GRANT ALL PRIVILEGES ON $SQL_DB.* TO '$SQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASS';
FLUSH PRIVILEGES;
EOF
	
	mysqld --user=mysql --bootstrap < $TMPFILE
	rm -f $TMPFILE
fi
mysqld --user=mysql --console
