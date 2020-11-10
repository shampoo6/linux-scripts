#! /bin/bash
echo 'system init'
echo '==========='
yum update -y
yum install -y vim

# 初始化 crontab
crontab /etc/crontab

# 设置同步时区操作
yum install -y ntp ntpdate
if [! -f '/opt/sync-time.sh']
then
    echo '
        #! /bin/bash
        ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime # 设置时区
        service ntpd stop # 停止同步服务
        ntpdate cn.pool.ntp.org # 在线同步时间
        hwclock --systohc # 硬件时间和系统时间同步
        date # 读取系统时间
        echo "sync time over"
    ' > /opt/sync-time.sh
    chmod -R 777 /opt/sync-time.sh
    echo 'create sync-time.sh'
else
    echo 'sync-time.sh exist'
fi

# 首次同步时间
/opt/sync-time.sh

## 加入计划任务
if [ `grep -c '/opt/sync-time.sh' /etc/crontab` -eq '0' ]
then
    echo '* * * * * root /opt/sync-time.sh' >> /etc/crontab
fi

echo 'system init over'
