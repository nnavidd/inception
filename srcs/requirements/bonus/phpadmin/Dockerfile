# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnabaeei <nnabaeei@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/23 11:47:40 by nnabaeei          #+#    #+#              #
#    Updated: 2024/10/23 16:48:46 by nnabaeei         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends php7.4-fpm phpmyadmin
    # php7.4-pdo_mysql \
    # php7.4-mysqli \
    # php7.4-mbstring \
    # php7.4-xml \
    # php7.4-gd \
    # php7.4-curl \
    # php7.4-json \
    # php7.4-zip \
    # php7.4-bcmath \
    # php7.4-xmlrpc \
    # php7.4-soap \
    # php7.4-xsl \
    # php7.4-dom \
    # php7.4-simplexml \

# Configure PHPMyAdmin
ENV PMA_HOST=${PMA_HOST:-mariadb}
ENV PMA_PORT=${PMA_PORT:-3306}
ENV PMA_ARBITRARY=${PMA_ARBITRARY:-1}

RUN sed -i "s/\$cfg['blowfish_secret'] = '';/\$cfg['blowfish_secret'] = '$PMA_SECRET';/" /usr/share/phpmyadmin/config.inc.php

# Expose port
EXPOSE 8080

# Start PHP-FPM
CMD ["php-fpm"]