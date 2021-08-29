# README
脚本是基于 centos7 制作的

## 脚本功能介绍
脚本 | 功能
--- | ---
`sys-init-centos7.sh` | 初始化安装好的centos7系统
`docker-install-centos7.sh` | 安装docker和docker-compose
`mongodb-docker-compose.yml` | mongodb的docker-compose配置
`setup.sh` | 设置系统并安装docker
`setup-mongodb.sh` | 基于setup.sh安装mongodb

## 使用
```batch
# 克隆仓库
git clone https://github.com/shampoo6/linux-scripts.git
# 要运行哪个脚本就设置哪个脚本的可执行权限
# 以setup.sh脚本为例
chmod +x ./setup.sh
# 运行脚本
./setup.sh
```