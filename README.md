# shell-lib

## trojan-quickstart-plus

[Click to see usage details](https://github.com/ylbo/shell-lib/blob/master/trojan-quickstart-plus.md)

## modify-network centos6
```
curl -fsSL https://raw.githubusercontent.com/ylbo/shell-lib/master/modify-network.sh >> modify-network.sh

bash modify-network.sh [ifcfg-eth file suffix number] [ip] [gateway] [deviceNumber] [dns] [prefix]
````
The first three parameters must be filled in.The dns defaults to the same as the gateway.The prefix default 24.The deviceNumber default 0.

## install hadoop 2.7.7 (centos)
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ylbo/shell-lib/master/install_hadoop.sh)"
```
##  Aliyun uninstall AliYunDun（centos）
```
yum install -y wget && wget https://raw.githubusercontent.com/ylbo/shell-lib/master/remove_AliYunDun && chmod +x remove_AliYunDun && ./remove_AliYunDun
```
## install Docker-ce (centos7)
```
yum install -y wget && wget https://raw.githubusercontent.com/ylbo/shell-lib/master/install_docker && chmod +x install_docker && ./install_docker
```
## ubuntu 18.04 optimization
```
sudo add-apt-repository ppa:greaterfire/trojan && sudo apt-get update && sudo apt-get install trojan -y

wget https://raw.githubusercontent.com/ylbo/shell-lib/master/install_ubuntu && chmod +x install_ubuntu && ./install_ubuntu
```