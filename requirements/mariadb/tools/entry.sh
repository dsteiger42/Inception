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
    CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
    CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
    GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
    FLUSH PRIVILEGES;
EOF

    echo "Bootstrapping initial SQL..."
    mysqld --user=mysql --datadir=/var/lib/mysql --bootstrap < $TMPFILE
    rm -f $TMPFILE
fi

# Start MariaDB in foreground
exec mysqld --user=mysql --console