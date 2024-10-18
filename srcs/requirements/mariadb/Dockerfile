# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnabaeei <nnabaeei@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/13 11:26:50 by nnabaeei          #+#    #+#              #
#    Updated: 2024/10/18 10:39:09 by nnabaeei         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Use Debian Bullseye as the base image
FROM debian:bullseye

# Update the package manager
RUN apt-get update && apt-get install -y mariadb-server gettext-base
RUN mkdir -p /run/mysql && chown mysql:mysql /run/mysql
# RUN chown -R mysql:mysql /var/lib/mysql
# RUN chmod -R 755 /var/lib/mysql
# Expose the default MariaDB port
EXPOSE 3306

# Copy the configuration file if you want to add custom MariaDB configs
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Run the MariaDB server in the foreground
CMD ["mysqld_safe"]