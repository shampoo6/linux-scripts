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

# 由于 docker-clean 在执行 run 以后，会清除掉所有停止的 docker容器，如果有数据库容器的话，而且如果是停止状态的话，数据库就会被清掉，非常危险
# docker-clean 作者说后续 golang 的 release 版本会增加一个 exclude 排除列表，以后再看

# 可以自行选择关闭该任务

# if [ `grep -c '/opt/docker-clean' /etc/crontab` -eq '0' ]
# then
#     echo '*/30 * * * * root /opt/docker-clean/docker-clean run' >> /etc/crontab
#     echo 'start docker-clean task'
# else
#     echo 'docker-clean task exist'
# fi

# 设置镜像地址
# 发现设置镜像地址后，速度反而变慢了
echo 'start set docker mirrors'
echo '{
  "registry-mirrors": [
    "https://xznw8bfn.mirror.aliyuncs.com",
    "https://hub-mirror.c.163.com",
    "https://mirror.baidubce.com"
  ]
}' > /etc/docker/daemon.json
chmod -R 777 /etc/docker/daemon.json
systemctl daemon-reload
systemctl restart docker
echo 'set docker mirrors over'

# 安装 docker-compose 二进制包
curl -L https://github.com/docker/compose/releases/download/1.25.5/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
# 获取执行权限
chmod +x /usr/local/bin/docker-compose

# 运行 demo 如果执行成功说明安装完成
docker run hello-world