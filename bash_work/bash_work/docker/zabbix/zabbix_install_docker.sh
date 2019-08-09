#!/usr/bin/env bash
set -x
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

cur_dir=$(cd $(dirname "$0") && pwd)
echo "脚本执行路径:"${cur_dir}
DATE=`date +%Y%m%d_%H%M%S`
echo "当前时间:"${DATE}

#if [ $# -eq "0" ]; then
#    echo "没有参数"
#fi

docker run --name mysql-server -t  -e MYSQL_DATABASE="zabbix"  -e MYSQL_USER="zabbix"  -e MYSQL_PASSWORD="zabbix_pwd"  -e MYSQL_ROOT_PASSWORD="root_pwd"  -d mysql:5.7 
docker run -d -p 9000:9000 --restart=always -v /var/run/docker.sock:/var/run/docker.sock --name prtainer portainer/portainer 
docker run --name zabbix-java-gateway -t  -d zabbix/zabbix-java-gateway:latest 
docker run --name zabbix-server-mysql -t  -e DB_SERVER_HOST="mysql-server"  -e MYSQL_DATABASE="zabbix"  -e MYSQL_USER="zabbix"  -e MYSQL_PASSWORD="zabbix_pwd"  -e MYSQL_ROOT_PASSWORD="root_pwd"  -e ZBX_JAVAGATEWAY="zabbix-java-gateway"  --link mysql-server:mysql  --link zabbix-java-gateway:zabbix-java-gateway  -p 10051:10051  -d zabbix/zabbix-server-mysql:latest 
docker run --name zabbix-web-nginx-mysql -t  -e DB_SERVER_HOST="mysql-server"  -e MYSQL_DATABASE="zabbix"  -e MYSQL_USER="zabbix"  -e MYSQL_PASSWORD="zabbix_pwd"  -e MYSQL_ROOT_PASSWORD="root_pwd"  --link mysql-server:mysql  --link zabbix-server-mysql:zabbix-server  -p 8088:80  -d zabbix/zabbix-web-nginx-mysql:latest 
