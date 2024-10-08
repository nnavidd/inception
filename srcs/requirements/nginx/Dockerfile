# This image is creating from the bullseys version of debian as its base OS
FROM debian:bullseye

# before installing nginx, the package mgmnt needs to be updated
RUN apt-get update

# installing nginx and openssl with the -y option to answer 'YES' to any prompts that might arise during the package installation process.
RUN apt-get install -y nginx openssl

# create a folder to keep the SSL certificate
RUN mkdir /etc/nginx/ssl

# generate SSL certificate using OpenSSL.
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=DE/ST=Heilbronn/L=Heilbronn/O=42_School/OU=nnabaeei/CN=Inception/title=Engineer/surname=Nabaeei"


# copy the customized nginx config to the docker container 
COPY ./srcs/requirements/nginx/conf/nginx.conf /etc/nginx/nginx.conf

# expose prot that the nginx would be accessable inside the docker container (since it is secured we use the 443 which is using for HTTPs)
EXPOSE 443

# the command that the docker container would be run with
CMD ["nginx", "-g", "daemon off;"]
