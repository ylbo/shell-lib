# shell_lib
这仓库存放一键脚本 便于使用

## 阿里云云盾一键卸载脚本
yum install -y wget && wget https://raw.githubusercontent.com/ylbo/shell_lib/master/remove_AliYunDun && chmod +x remove_AliYunDun && ./remove_AliYunDun

## Centos7 自动安装Docker-ce及配置阿里镜像加速源
yum install -y wget && wget https://raw.githubusercontent.com/ylbo/shell_lib/master/install_docker && chmod +x install_docker && ./install_docker

## ubuntu 一键优化
sudo add-apt-repository ppa:greaterfire/trojan
sudo apt-get update
sudo apt-get install trojan
wget https://raw.githubusercontent.com/ylbo/shell_lib/master/install_ubuntu && chmod +x install_ubuntu && ./install_ubuntu
