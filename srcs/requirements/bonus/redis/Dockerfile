# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnabaeei <nnabaeei@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/29 10:10:39 by nnabaeei          #+#    #+#              #
#    Updated: 2024/11/12 11:15:27 by nnabaeei         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Dockerfile for Redis on Debian Bullseye
FROM debian:bullseye

# Install Redis
RUN apt-get update && \
    apt-get install -y redis-server nano iputils-ping && \
    rm -rf /var/lib/apt/lists/*

# # Expose Redis default port
EXPOSE 6379

COPY ./tools/redis-entrypoint.sh /tmp/redis.sh
RUN chmod +x /tmp/redis.sh

ENTRYPOINT ["/tmp/redis.sh"]

CMD ["redis-server", "--protected-mode no"]

# check access: redis-cli -h redis_service ping
# it should return pong
