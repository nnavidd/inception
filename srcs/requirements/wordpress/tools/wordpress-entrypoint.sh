#!/bin/sh

rm -f ./wp-config.php

# Wait for the database to be available
echo "Waiting for MariaDB to be available..."
until mysqladmin ping -h "$WORDPRESS_DB_HOST" --silent; do
    echo "MariaDB is unavailable - waiting..."
    sleep 3
done

# Wait for Redis to be available
echo "Waiting for Redis to be available..."
until redis-cli -h redis -p 6379 ping; do
    echo "Redis is unavailable - waiting..."
    sleep 3
done

# Check if wp-config.php exists
if [ -f ./wp-config.php ]; then
    echo "WordPress already configured."
else
    # Import environment variables into wp-config.php
    sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" wp-config-sample.php
    sed -i "s/username_here/$WORDPRESS_DB_USER/g" wp-config-sample.php
    sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$WORDPRESS_DB_HOST/g" wp-config-sample.php
    sed -i "s/define( 'WP_DEBUG', false );/define( 'WP_DEBUG', true );/g" wp-config-sample.php
    cp wp-config-sample.php wp-config.php 2>&1 | tee /var/log/wp-install.log

    # Install WordPress using WP-CLI with root permissions
    echo "Starting WordPress installation..."
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="$TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email --allow-root 2>&1 | tee -a /var/log/wp-install.log

    echo "WordPress installation completed."

    echo "Starting redis configuration..."
	wp config set WP_REDIS_HOST redis --allow-root
  	wp config set WP_REDIS_PORT 6379 --raw --allow-root
 	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
 	wp config set WP_REDIS_CLIENT phpredis --allow-root
	wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
	wp redis enable --allow-root
    echo "Redis configuration completed."
fi

# Execute the container’s command
exec "$@"
