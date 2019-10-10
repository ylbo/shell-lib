# trojan-quickstart-plus

Referring to this article [click here](https://trojan-tutor.github.io/2019/04/10/p41.html), this script automatically completes the fifth step after you complete steps 1 to 4.

This script is only tested on debian 9. 
Do not use this script in centos system.


# Usage

**Please execute the following two commands before executing the script.**

After logging in to cloudflare, navigate to: avatar>>My Profile>>API Tokens. Can see the Global API Key
```
export CF_Key="Your Global API Key"
```
```
export CF_Email="Your cloudflare account Email"
````
## curl
```
curl -fsSL https://raw.githubusercontent.com/ylbo/shell-lib/master/trojan-quickstart-plus.sh >> trojan-quickstart-plus.sh
```

## Description
``` 
bash trojan-quickstart-plus.sh [loginVpsUsername] [domain] [ip] [trojanPassword] [reverseProxyWebsite] [mysqlPassword]
```
The first four parameters must be filled in. Turn on nginx if you have set [reverseProxyWebsite] option, otherwise nginx will not be enabled. The [mysqlPassword] option same as the last one. 

## exameple: 
``` 
bash trojan-quickstart-plus.sh r&@#1d2s23 123.xyz 47.99.11.13 123456
```
``` 
bash trojan-quickstart-plus.sh r&@#1d2s23 123.xyz 47.99.11.13 123456 www.fanyi.baidu.com
```
``` 
bash trojan-quickstart-plus.sh r&@#1d2s23 123.xyz 47.99.11.13 123456 www.fanyi.baidu.com 1594656
```
## Tips
It is recommended to copy the command to the notepad to modify it, and then confirm that it is correct and then run.

# Reference
[https://trojan-tutor.github.io/2019/04/10/p41.html](https://trojan-tutor.github.io/2019/04/10/p41.html)

[https://github.com/trojan-gfw/trojan-quickstart](https://github.com/trojan-gfw/trojan-quickstart)