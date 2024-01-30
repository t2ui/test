# 使用 Ubuntu 为基础镜像
FROM ubuntu:latest

# 安装 MySQL 和 Redis
RUN apt-get update && apt-get install -y mysql-server redis-server wget

# 安装 Docker 客户端
RUN apt-get install -y docker.io

# 复制数据库初始化脚本
COPY ./docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/

# 将 start.sh 脚本复制到镜像中
COPY start.sh /start.sh
RUN chmod +x /start.sh

# 设置环境变量
ENV TZ=Asia/Shanghai
ENV MYSQL_ROOT_PASSWORD=123456
ENV MYSQL_DATABASE=cool
ENV MYSQL_USER=cool
ENV MYSQL_PASSWORD=123123

# 暴露必要的端口
EXPOSE 8200 80

# 设置容器启动时执行的命令
CMD ["/start.sh"]
