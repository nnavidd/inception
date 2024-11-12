# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnabaeei <nnabaeei@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/13 11:26:50 by nnabaeei          #+#    #+#              #
#    Updated: 2024/11/12 10:38:08 by nnabaeei         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

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


# mysqld_safe: Adds safety features like automatic restart and error logging.
# mysqld: Directly starts the MySQL server without additional safety features.
# mysql.server: A script that uses mysqld_safe to start and stop the MySQL server, often integrated with system service management.
# Using mysqld_safe is recommended for its added reliability and logging capabilities, especially in production environments.
# Run the MariaDB server in the foreground
CMD ["mysqld_safe"]


#commands:
# mysql -u <user name> -p<pwd>
# select database: USE <your_database_name>;
# slecet table: SELECT * FROM <your_table_name>;
# display column or row: SELECT <column1>, <column2> FROM <your_table_name>;