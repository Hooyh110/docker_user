#!/bin/bash

if [ $# -eq "0" ]; then
echo "错误参数"
exit 1
fi

domainName=$1

ansible 10.13.0.7,10.13.0.8 -m copy -a "src=/home/liuhonghe/ansible-nginx/disable_vhosts/$domainName dest=/usr/local/nginx/conf/disable_vhosts/" -f 5 --sudo
#ansible 10.13.0.8 -m copy -a "src=/home/liuhonghe/ansible-nginx/disable_vhosts/$domainName dest=/usr/local/nginx/conf/disable_vhosts/" --sudo

ansible 10.13.0.7,10.13.0.8 -m shell -a "/usr/local/nginx/sbin/nginx -t" -f 5 --sudo
#ansible 10.13.0.8 -m shell -a "/usr/local/nginx/sbin/nginx -t" --sudo

if [ $# -eq "2" ]; then
	ansible 10.13.0.7,10.13.0.8 -m shell -a "/usr/local/nginx/sbin/nginx -s reload" --sudo
	#ansible 10.13.0.8 -m shell -a "/usr/local/nginx/sbin/nginx -s reload" --sudo
fi
