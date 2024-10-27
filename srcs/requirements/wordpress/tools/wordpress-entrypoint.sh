#!/bin/sh
rm -f ./wp-config.php

# Wait for the database to be available
echo "Waiting for MariaDB to be available..."
until mysqladmin ping -h "$WORDPRESS_DB_HOST" --silent; do
    echo "MariaDB is unavailable - waiting..."
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
    cp wp-config-sample.php wp-config.php 2>&1 | tee /var/log/wp-install.log

    # Install WordPress with WP-CLI, adding --allow-root to all commands
    echo "starting to install wordpress"
	wp core install \
        --url="$DOMAIN_NAME" \
        --title="Your Site Title" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email --allow-root 2>&1 | tee -a /var/log/wp-install.log

    echo "WordPress installation completed."

    # Install and activate a plugin (e.g., Yoast SEO)
    wp plugin install yoast-seo --activate --allow-root
fi

exec "$@"
