# 使用基础镜像
FROM ubuntu:20.04

# 设置工作目录
WORKDIR /app

# 复制当前目录下的所有文件和子目录到容器的 /app 目录
COPY . /app

RUN chmod +x deploy.sh
CMD ["deploy.sh"]
