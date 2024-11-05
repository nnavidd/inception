#!/bin/sh

if [ ! -f "/etc/redis/redis.conf.bak" ]; then

	#The .bak is created to notify the program if it exists, don't go to the loop anymore
    cp /etc//redis/redis.conf /etc/redis/redis.conf.bak

    sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis/redis.conf
    sed -i "s|# maxmemory <bytes>|maxmemory 2mb|g" /etc/redis/redis.conf
    sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis/redis.conf

fi

exec "$@"