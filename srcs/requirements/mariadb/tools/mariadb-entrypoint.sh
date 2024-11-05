#!/bin/bash

# Exit script on error
set -e

# read from the secrets path that is created by the secrets attribute of the docker compose
WORDPRESS_DB_PASSWORD=$(cat /run/secrets/wp_db_pwd)
MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_pw)

# Check if MariaDB data directory is already initialized
if [ -d "/var/lib/mysql/mysql" ]; then
  echo "MariaDB directory already initialized."
else
  echo "MariaDB data directory not found. Initializing..."
  # Initialize the MariaDB data directory
  mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB in the background to perform setup
mysqld_safe --skip-networking &
mariadb_pid="$!"

# Wait for MariaDB to be ready for connections
echo "Waiting for MariaDB to start..."
until mysqladmin ping --silent; do
  sleep 2
done

# Check if root user has a password
if mysql -uroot -e "SELECT 1" &>/dev/null; then
  echo "Root user exists."
else
  echo "Setting root password..."
  mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
fi

# Create WordPress database and user if they don't exist
echo "Checking if WordPress database exists..."
DB_EXISTS=$(mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW DATABASES LIKE '${WORDPRESS_DB_NAME}';" | grep "${WORDPRESS_DB_NAME}" || true)
if [ -z "$DB_EXISTS" ]; then
  echo "Creating WordPress database: ${WORDPRESS_DB_NAME}"
  mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE ${WORDPRESS_DB_NAME};"
else
  echo "Database ${WORDPRESS_DB_NAME} already exists."
fi

# Check if WordPress user exists
USER_EXISTS=$(mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "SELECT User FROM mysql.user WHERE User = '${WORDPRESS_DB_USER}';" | grep "${WORDPRESS_DB_USER}" || true)
if [ -z "$USER_EXISTS" ]; then
  echo "Creating WordPress user: ${WORDPRESS_DB_USER}"
  mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER '${WORDPRESS_DB_USER}'@'%' IDENTIFIED BY '${WORDPRESS_DB_PASSWORD}';"
  mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${WORDPRESS_DB_USER}'@'%';"
else
  echo "User ${WORDPRESS_DB_USER} already exists."
fi

# Flush privileges and stop MariaDB background process
mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Wait for the background process to stop
wait "$mariadb_pid"

# Restart MariaDB in the foreground
# exec mysqld_safe
exec "$@"