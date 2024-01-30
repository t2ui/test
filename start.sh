#!/bin/bash

# 启动 MySQL
service mysql start

# 等待 MySQL 完全启动
while ! mysqladmin ping -h"localhost" --silent; do
    sleep 1
done

# 初始化数据库
mysql -u root -p"$MYSQL_ROOT_PASSWORD" < /docker-entrypoint-initdb.d/cool.sql

# 启动 Redis
service redis-server start

# 下载并启动 xyhelper/chatgpt-mirror-server
docker pull xyhelper/chatgpt-mirror-server:latest
docker run -d -p 8200:8001 --name chatgpt-mirror-server xyhelper/chatgpt-mirror-server:latest

# 保持容器运行
tail -f /dev/null
