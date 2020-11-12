#! /bin/sh
echo 'system init'
echo '==========='
yum update -y
yum install -y vim
yum install -y git

# 初始化 crontab
crontab /etc/crontab

# 设置同步时区操作
yum install -y ntp ntpdate
# 方括号后面必须要有空格
if [ ! -f '/opt/sync-time.sh' ]
then
    echo '
        #! /bin/sh
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
if [ `grep -c '/opt/sync-time.sh' /etc/crontab` -eq '0' ];
then
    echo '0 * * * * root /opt/sync-time.sh' >> /etc/crontab
    echo 'add task for sync time'
else
    echo 'sync time task exist'
fi

# 创建清理缓存脚本
if [ ! -f '/opt/cache-clean.sh' ]
then
    echo '
        #! /bin/sh
        date
        sync && echo 1 > /proc/sys/vm/drop_caches
        sync && echo 2 > /proc/sys/vm/drop_caches
        sync && echo 3 > /proc/sys/vm/drop_caches
        echo "cache-clean over"
    ' > /opt/cache-clean.sh
    chmod -R 777 /opt/cache-clean.sh
    echo 'create cache-clean.sh'
else
    echo 'cache-clean.sh exist'
fi

## 加入计划任务
if [ `grep -c '/opt/cache-clean.sh' /etc/crontab` -eq '0' ];
then
    echo '0 * * * * root /opt/cache-clean.sh' >> /etc/crontab
    echo 'add task for cache-clean'
else
    echo 'cache-clean task exist'
fi

echo 'system init over'
