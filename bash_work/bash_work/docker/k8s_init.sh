#!/usr/bin/env bash
set -x
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

cur_dir=$(cd $(dirname "$0") && pwd)
echo "脚本执行路径:"${cur_dir}
DATE=`date +%Y%m%d_%H%M%S`
echo "当前时间:"${DATE}
function init() {
    systemctl stop firewalld.service
    systemctl disable firewalld.service
    curl -o /etc/yum.repos.d/docker-ce.repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    #创建kubernetes的yum源文件：
    echo "[kubernetes]
    name=Kubernetes Repo
    baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
    gpgcheck=1
    gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
    enabled=1" >> /etc/yum.repos.d/kubernetes.repo
    #将这两个repo文件 复制到其他节点的/etc/yum.repo.d目录中：
    #for i in node01 node02; do scp /etc/yum.repos.d/{docker-ce.repo,kubernetes.repo} $i:/etc/yum.repos.d/; done
    #安装yum源的检验key:
    curl -O https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg && rpm --import rpm-package-key.gpg
    #（2）安装docker、kubelet、kubeadm、kubectl
    yum install docker-ce kubelet kubeadm kubectl -y
    #（3）修改防火墙
    echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables 
    echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
    iptables -P  FORWARD ACCEPT
    #永久生效
    sed -i "s/0/1/g" /usr/lib/sysctl.d/00-system.conf
    #tr将大写字母全部替换为小写
    selinux_stat="$(getenforce | tr '[:upper:]' '[:lower:]' )"
    sed -i "s/SELINUX=${selinux_stat}/SELINUX=disable/g" /etc/selinux/config
    sysctl -p
    #在指定行增加信息
    sed -i '/# for containers run by docker/aEnvironment="NO_PROXY=127.0.0.1/8,127.0.0.1/16"' /lib/systemd/system/docker.service
    systemctl daemon-reload && systemctl  start docker &&  systemctl enable docker
    systemctl  enable  kubelet
    #初始化kubelet
    sed -i 's/KUBELET_EXTRA_ARGS=/KUBELET_EXTRA_ARGS="--fail-swap-on=false"/g' /etc/sysconfig/kubelet
}
init
