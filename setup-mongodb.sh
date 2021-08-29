# 初始化主机
chmod +x ./setup.sh
./setup.sh

# 执行当前文件夹下的 compose 任务流
docker-compose -f mongodb-docker-compose.yml up -d

# 添加防火墙配置
firewall-cmd --add-port=27017/tcp --permanent
firewall-cmd --add-port=8081/tcp --permanent
firewall-cmd --reload