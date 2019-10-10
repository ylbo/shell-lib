# shell-lib

## trojan-quickstart-plus

[Click to see usage details](https://github.com/ylbo/shell-lib/blob/master/trojan-quickstart-plus.md)

## modify-network centos6
```
curl -fsSL https://raw.githubusercontent.com/ylbo/shell-lib/master/modify-network.sh >> modify-network.sh

bash modify-network.sh [fileSuffixNumber] [ip] [gateway] [dns] [prefix]
````
The first three parameters must be filled in. DNS defaults to the same as the gateway. The prefix default 24.

##  Aliyun automatic uninstall AliYunDun（centos）
```
yum install -y wget && wget https://raw.githubusercontent.com/ylbo/shell-lib/master/remove_AliYunDun && chmod +x remove_AliYunDun && ./remove_AliYunDun
```
## Centos7 automatic install Docker-ce
```
yum install -y wget && wget https://raw.githubusercontent.com/ylbo/shell-lib/master/install_docker && chmod +x install_docker && ./install_docker
```
## ubuntu 18.04 automatic optimization
```
sudo add-apt-repository ppa:greaterfire/trojan && sudo apt-get update && sudo apt-get install trojan -y

wget https://raw.githubusercontent.com/ylbo/shell-lib/master/install_ubuntu && chmod +x install_ubuntu && ./install_ubuntu
```