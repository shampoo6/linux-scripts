#! /bin/bash

# CentOS7 环境下的docker安装

# 使用阿里的脚本
echo 'start install docker'
curl -fsSL get.docker.com -o get-docker.sh \
&& sudo sh get-docker.sh --mirror Aliyun
echo 'start docker'
systemctl enable docker
systemctl start docker

# 安装docker-clean
echo 'start clone docker-clean'
git clone https://github.com/ZZROTDesign/docker-clean.git /opt/docker-clean
chmod -R 777 /opt/docker-clean
echo 'docker-clean install over'

if [ `grep -c '/opt/docker-clean' /etc/crontab` -eq '0' ]
then
    echo '*/30 * * * * root /opt/docker-clean/docker-clean run' >> /etc/crontab
    echo 'start docker-clean task'
else
    echo 'docker-clean task exist'
fi

# 设置镜像地址
# 发现设置镜像地址后，速度反而变慢了
# echo 'start set docker mirrors'
# echo '{
#   "registry-mirrors": [
#     "https://xznw8bfn.mirror.aliyuncs.com",
#     "https://hub-mirror.c.163.com",
#     "https://mirror.baidubce.com"
#   ]
# }' > /etc/docker/daemon.json
# chmod -R 777 /etc/docker/daemon.json
# systemctl daemon-reload
# systemctl restart docker
# echo 'set docker mirrors over'

# 运行 demo 如果执行成功说明安装完成
docker run hello-world