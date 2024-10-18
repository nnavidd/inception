# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnabaeei <nnabaeei@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/13 11:27:06 by nnabaeei          #+#    #+#              #
#    Updated: 2024/10/13 11:58:00 by nnabaeei         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# # This image is creating from the bullseys version of debian as its base OS
# FROM debian:bullseye

# ARG PORT1
# ENV PORT2 ${PORT1}

# # before installing nginx, the package mgmnt needs to be updated
# RUN apt-get update

# # installing nginx and openssl with the -y option to answer 'YES' to any prompts that might arise during the package installation process.
# RUN apt-get install -y nginx openssl gettext-base

# # create a folder to keep the SSL certificate
# RUN mkdir /etc/nginx/ssl

# RUN echo ${PORT2}
# RUN echo ${PORT1}
# # generate SSL certificate using OpenSSL.
# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=DE/ST=Heilbronn/L=Heilbronn/O=42_School/OU=navid nabaeei/CN=Inception/title=Engineer/surname=Nabaeei"


# # copy the customized nginx config to the docker container 
#  COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# # expose prot that the nginx would be accessable inside the docker container (since it is secured we use the 443 which is using for HTTPs)
# # EXPOSE 443
# EXPOSE ${PORT2}

# # the command that the docker container would be run with
# CMD ["nginx", "-g", "daemon off;"]


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
