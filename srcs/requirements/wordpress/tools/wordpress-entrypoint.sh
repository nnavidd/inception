#!/bin/sh

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

    # Install WordPress with WP-CLI
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="Your Site Title" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email  2>&1 | tee -a /var/log/wp-install.log

    echo "WordPress installation completed."

    # Install and activate a plugin (e.g., Yoast SEO)
    wp plugin install yoast-seo --activate

    # You can install multiple plugins in the same way
    # wp plugin install plugin-slug --activate
fi

exec "$@"
