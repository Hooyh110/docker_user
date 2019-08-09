#!/usr/bin/env bash
set -x
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

cur_dir=$(cd $(dirname "$0") && pwd)
echo "脚本执行路径:"${cur_dir}
DATE=`date +%Y%m%d_%H%M%S`
echo "当前时间:"${DATE}

if [ $# -eq "0" ]; then
    echo "没有参数"
fi

docker pull mirrorgooglecontainers/kube-apiserver-amd64:v1.13.1
docker pull mirrorgooglecontainers/kube-controller-manager-amd64:v1.13.1
docker pull mirrorgooglecontainers/kube-scheduler-amd64:v1.13.1
docker pull mirrorgooglecontainers/kube-proxy-amd64:v1.13.1
docker pull mirrorgooglecontainers/pause:3.1
docker pull mirrorgooglecontainers/etcd-amd64:3.2.24
docker pull coredns/coredns:1.2.6

docker tag mirrorgooglecontainers/kube-apiserver-amd64:v1.13.1 k8s.gcr.io/kube-apiserver:v1.13.1
docker tag mirrorgooglecontainers/kube-controller-manager-amd64:v1.13.1 k8s.gcr.io/kube-controller-manager:v1.13.1
docker tag mirrorgooglecontainers/kube-scheduler-amd64:v1.13.1  k8s.gcr.io/kube-scheduler:v1.13.1
docker tag mirrorgooglecontainers/kube-proxy-amd64:v1.13.1  k8s.gcr.io/kube-proxy:v1.13.1
docker tag mirrorgooglecontainers/pause:3.1 k8s.gcr.io/pause:3.1
docker tag mirrorgooglecontainers/etcd-amd64:3.2.24  k8s.gcr.io/etcd:3.2.24
docker tag coredns/coredns:1.2.6  k8s.gcr.io/coredns:1.2.6

docker rmi -f mirrorgooglecontainers/kube-apiserver-amd64:v1.13.1
docker rmi -f  mirrorgooglecontainers/kube-controller-manager-amd64:v1.13.1
docker rmi -f  mirrorgooglecontainers/kube-scheduler-amd64:v1.13.1
docker rmi -f  mirrorgooglecontainers/kube-proxy-amd64:v1.13.1
docker rmi -f  mirrorgooglecontainers/pause:3.1
docker rmi -f  mirrorgooglecontainers/etcd-amd64:3.2.24
docker rmi -f  moredns/coredns:1.2.6
