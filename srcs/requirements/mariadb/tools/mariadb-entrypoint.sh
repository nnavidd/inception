#!/bin/bash

# Exit script on error
set -e

# Initialize MariaDB data directory if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "MariaDB data directory is not initialized. Initializing..."
    mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    
    # Start MariaDB temporarily to run the initial setup
    mysqld_safe --skip-networking &
    pid="$!"

    # Wait for MariaDB to be ready (loop until successful connection)
    while ! mysqladmin ping --silent; do
        echo "Waiting for MariaDB to be ready..."
        sleep 2
    done

    # Run initial database setup
    echo "Setting up initial database..."

    # Create root user with password
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    echo "Root user password set."

    # Create the specified database if provided
    if [ -n "${MYSQL_DATABASE}" ]; then
        echo "Creating database: ${MYSQL_DATABASE}"
        mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    fi

    # Create the specified user and grant privileges if provided
    if [ -n "${MYSQL_USER}" ] && [ -n "${MYSQL_PASSWORD}" ]; then
        echo "Creating user: ${MYSQL_USER} with password ${MYSQL_PASSWORD}"
        mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
        
        if [ -n "${MYSQL_DATABASE}" ]; then
            echo "Granting privileges on ${MYSQL_DATABASE} to ${MYSQL_USER}"
            mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
        fi
    fi

    # Flush privileges to ensure they are available
    mysql -e "FLUSH PRIVILEGES;"

    # Shutdown MariaDB after setup
    mysqladmin shutdown
    echo "Initial database setup complete."
fi

# Start MariaDB server (mysqld_safe ensures proper startup)
exec "$@"
