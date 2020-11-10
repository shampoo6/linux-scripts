#! /bin/bash

# CentOS7 环境下的docker安装
# 使用阿里的脚本
curl -fsSL get.docker.com -o get-docker.sh \
&& sudo sh get-docker.sh --mirror Aliyun
# 运行 demo 如果执行成功说明安装完成
docker run hello-world