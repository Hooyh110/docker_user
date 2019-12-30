#!/usr/bin/env bash
#########################################################################
# File Name: all-service.sh
# Author: huyuhao
# weixin:huyuhao1910
# Created Time: Fri 24 Aug 2018 06:47:24 PM CST
#########################################################################

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
KUBE_DIR=$(cd $(dirname "$0") && pwd)
KUBECTL_1=maozhua-web
KUBECTL_2=innersystem
KUBECTL_3=xiongmaoyouche
KUBECTL_4=autosaas-pro
KUBECTL_5=autosaas-fat

cur_dir=$(cd $(dirname "$0") && pwd)




function help(){
  echo "Function: 1 2 3 4 5 "
  echo "Usage: $0 {1(maozhua-web)、2(innersystem)、3(xiongmaoyouche)、4(autosaas-pro)、5(autosaas-fat)}"
}
#maozhua-web
function MAOZHUA-WEB(){
 cp -rf  ${KUBE_DIR}/${KUBECTL_1} ~/.kube/config
}
#innersystem
function INNERSYSTEM(){
 cp -rf  ${KUBE_DIR}/${KUBECTL_2} ~/.kube/config
}
#xiongmaoyouche
function XIONGMAOYOUCHE(){
 cp -rf  ${KUBE_DIR}/${KUBECTL_3} ~/.kube/config
}
#autosaas-pro
function AUTOSAAS-PRO(){
 cp -rf  ${KUBE_DIR}/${KUBECTL_4} ~/.kube/config
}
#autosaas-fat
function AUTOSAAS-FAT(){
 cp -rf  ${KUBE_DIR}/${KUBECTL_5} ~/.kube/config
}
case "$1" in
  1)
    MAOZHUA-WEB
  ;;
  2)
    INNERSYSTEM
  ;;
  3)
    XIONGMAOYOUCHE
  ;;
  4)
    AUTOSAAS-PRO
  ;;
  5)
    AUTOSAAS-FAT
  ;;
  *)
    help
    exit 1
  ;;
esac
