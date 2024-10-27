# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnabaeei <nnabaeei@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/13 11:26:50 by nnabaeei          #+#    #+#              #
#    Updated: 2024/10/25 10:43:06 by nnabaeei         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# # Use Debian Bullseye as the base image
# FROM debian:bullseye

# # Update the package manager
# RUN apt-get update && apt-get install -y mariadb-server gettext-base

# # Create necessary directories for the Unix socket
# # RUN mkdir -p /run/mysql && chown mysql:mysql /run/mysql
# # RUN chown -R mysql:mysql /var/lib/mysql
# # RUN chmod -R 755 /var/lib/mysql
# # Expose the default MariaDB port
# EXPOSE 3306


# # Copy custom entrypoint script to handle initialization and permissions
# COPY ./tools/mariadb-entrypoint.sh /usr/local/bin/mariadb-entrypoint.sh
# RUN chmod +x /usr/local/bin/mariadb-entrypoint.sh

# # Copy the configuration file if you want to add custom MariaDB configs
# COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# # Run the custom entrypoint script
# ENTRYPOINT ["/usr/local/bin/mariadb-entrypoint.sh"]

# # Run the MariaDB server in the foreground
# CMD ["mysqld_safe"]

# Use Debian Bullseye as the base image
FROM debian:bullseye

# Update the package manager and install MariaDB server
RUN apt-get update && apt-get install -y mariadb-server gettext-base

# Expose the default MariaDB port
EXPOSE 3306

# Copy custom entrypoint script to handle initialization and permissions
COPY ./tools/mariadb-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb-entrypoint.sh

# Copy the configuration file if you want to add custom MariaDB configs
COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Run the custom entrypoint script
ENTRYPOINT ["/usr/local/bin/mariadb-entrypoint.sh"]

# Run the MariaDB server in the foreground
CMD ["mysqld_safe"]
