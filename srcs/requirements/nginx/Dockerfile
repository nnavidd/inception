# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnabaeei <nnabaeei@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/13 11:27:06 by nnabaeei          #+#    #+#              #
#    Updated: 2024/10/30 22:39:24 by nnabaeei         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

# there are two type variable in dockerfile 'ARG' and 'ENV'.
# 'ARG' used for the runtime that it could bring value from the docker compose by valueing it as the args indicator (subindicatr of build) with the same key as is defined in dockerfile.
# 'ENV' this type could get its value from the environment directive in the Dockerfile.
ARG VAR
ENV NGINX_PORT=${NGINX_PORT}

# Install necessary packages including gettext for envsubst (this fucntion will read the env values from env file 
# and substitues the placehoders inside the nignx.conf.template with actual values and generate a new file nginx.conf in its right palce as in ENTRYPOINT script is defined.)
RUN apt-get update && apt-get install -y nginx openssl gettext-base

# Create a folder to keep the SSL certificate
RUN mkdir /etc/nginx/ssl

# Generate SSL certificate using OpenSSL.
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=DE/ST=Heilbronn/L=Heilbronn/O=42_School/OU=navid nabaeei/CN=Inception/title=Engineer/surname=Nabaeei"

# Copy entrypoint script
COPY ./conf/nginx.conf.template /etc/nginx/nginx.conf.template
COPY ./tools/nginx-entrypoint.sh /usr/local/bin/nginx-entrypoint.sh
RUN chmod +x /usr/local/bin/nginx-entrypoint.sh

# Expose the port (use a default, which can be overridden via docker-compose.yml)
# for instance here I could use ${VAR} or ${NGINX_PORT}
EXPOSE ${VAR}

# Default command is to run the entrypoint script
ENTRYPOINT ["/usr/local/bin/nginx-entrypoint.sh"]
