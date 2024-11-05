# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnabaeei <nnabaeei@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/23 11:47:40 by nnabaeei          #+#    #+#              #
#    Updated: 2024/11/05 16:36:57 by nnabaeei         ###   ########.fr        #
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

# # Start PHP built-in server for Adminer
# "php": This is the command being executed. it is the PHP interpreter.
# "-S": This flag tells PHP to start a built-in web server. The -S option is used to specify the address and port on which the server should listen.
# "0.0.0.0:8080": This specifies the address and port for the PHP built-in web server. 0.0.0.0 means the server will listen on all available network interfaces, and 8080 is the port number.
# "-t": This flag specifies the document root for the server. The document root is the directory from which the server will serve files.
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]