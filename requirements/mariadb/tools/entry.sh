#!/bin/sh
set -e

# Ensure the socket directory exists
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Initialize the database if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB database..."
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql

    TMPFILE=$(mktemp)

    cat <<EOF > $TMPFILE
    CREATE DATABASE IF NOT EXISTS \`$SQL_DB\`;
    CREATE USER IF NOT EXISTS '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASS';
    GRANT ALL PRIVILEGES ON \`$SQL_DB\`.* TO '$SQL_USER'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$SQL_ROOT_PASS';
    FLUSH PRIVILEGES;
EOF

    echo "Bootstrapping initial SQL..."
    mysqld --user=mysql --datadir=/var/lib/mysql --bootstrap < $TMPFILE
    rm -f $TMPFILE
fi

# Start MariaDB in foreground
exec mysqld --user=mysql --console