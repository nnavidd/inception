# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nnabaeei <nnabaeei@student.42heilbronn.    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/29 10:10:39 by nnabaeei          #+#    #+#              #
#    Updated: 2024/10/30 18:48:10 by nnabaeei         ###   ########.fr        #
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

# # Start Redis with the custom configuration
# CMD ["redis-server", "/etc/redis/redis.conf"]


COPY ./tools/redis-entrypoint.sh /tmp/redis.sh
RUN chmod +x /tmp/redis.sh

ENTRYPOINT ["/tmp/redis.sh"]

CMD ["redis-server", "--protected-mode no"]
# CMD ["sh", "/tmp/redis.sh"]