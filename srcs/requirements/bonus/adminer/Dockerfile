# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnabaeei <nnabaeei@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/23 11:47:40 by nnabaeei          #+#    #+#              #
#    Updated: 2024/10/23 23:25:14 by nnabaeei         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Use Debian Bullseye as the base image
FROM debian:bullseye

# Install PHP and required extensions for Adminer
RUN apt-get update && \
    apt-get install -y php php-mysql curl wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Download the Adminer PHP file
RUN mkdir -p /var/www/html && \
    wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -O /var/www/html/index.php

# Expose the default Adminer port
EXPOSE 8080

# Start PHP built-in server for Adminer
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
