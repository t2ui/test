#!/bin/bash

# 启动 MySQL
docker run -d --name mysql \
 -e MYSQL_ROOT_PASSWORD=123456 \
 -e MYSQL_DATABASE=cool \
 -e MYSQL_USER=cool \
 -e MYSQL_PASSWORD=123123 \
 -v $(pwd)/data/mysql:/var/lib/mysql \
 -v $(pwd)/docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d \
 mysql:8 \
 --default-authentication-plugin=mysql_native_password \
 --character-set-server=utf8mb4 \
 --collation-server=utf8mb4_unicode_ci

# 启动 Redis
docker run -d --name redis \
 -v $(pwd)/data/redis:/data \
 redis

# 启动 ChatGPT 镜像服务
docker run -d --name chatgpt-mirror-server \
 -p 8200:8001 \
 -e CHATPROXY="https://demo.xyhelper.cn" \
 -e AUTHKEY="xyhelper" \
 -e ONLYTOKEN="true" \
 -v $(pwd)/data/chatgpt-mirror-server:/app/data \
 xyhelper/chatgpt-mirror-server:latest

# 启动 Watchtower
docker run -d --name watchtower \
 -v /var/run/docker.sock:/var/run/docker.sock \
 containrrr/watchtower \
 --scope xyhelper-chatgpt-mirror-server --cleanup
