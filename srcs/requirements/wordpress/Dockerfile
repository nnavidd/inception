# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnabaeei <nnabaeei@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/17 17:26:52 by nnabaeei          #+#    #+#              #
#    Updated: 2024/10/21 12:12:39 by nnabaeei         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Use Debian Bullseye as the base image
FROM debian:bullseye

# Install necessary packages: PHP-FPM, PHP extensions, and WordPress dependencies
RUN apt-get update 
RUN apt-get install -y php-fpm php-mysql curl wget unzip php-gd php-mbstring php-xml php-curl mariadb-client

# Copy the .conf in the html directory
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

#Create the folder to enable php start
RUN mkdir /run/php

# Download WordPress
WORKDIR /var/www/html
RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xvf latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress latest.tar.gz

#we copy the script, give the right to launch it in local on our computer
COPY ./tools/wordpress-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/wordpress-entrypoint.sh"]

# Set appropriate permissions for WordPress files
RUN chown -R www-data:www-data /var/www/html

# Expose port for PHP-FPM
EXPOSE 9000

# Start PHP-FPM to handle requests from Nginx
# CMD ["php-fpm"]




# Launch PHP FPM in foreground and ignore deamonize from conf file (-F)
CMD ["/usr/sbin/php-fpm7.4", "-F"]
# CMD ["/bin/bash"]