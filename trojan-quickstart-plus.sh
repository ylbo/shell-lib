#!/bin/bash

test=0

NAME=trojan
INSTALL_PREFIX=/usr/local
SERVER_CONFIG_PAT="$INSTALL_PREFIX/etc/$NAME/config.json"
CLIENT_CONFIG_PAT=config.json
NGINX_CONFIG=/etc/nginx/nginx.conf

USERNAME=$1
DOMAIN=$2
ADDRESS=$3
PASSWORD=$4
if [ -n "$5" ]
then 
    WEBSITE=$5
    NGINX=true
else
    NGINX=false
fi
if [ -n "$6" ]
then 
    ENABLEMYSQL=true
    MYSQLPW=$6
else
    ENABLEMYSQL=false
    MYSQLPW=""
fi

install_trojan(){
    sudo apt update
    sudo apt install -y socat cron curl lrzsz
    if [ ! -f ~/.acme.sh/acme.sh ]
    then
        curl  https://get.acme.sh | sh
        source ~/.bashrc 
    fi
    if [ $test == 1 ]
    then
        ~/.acme.sh/acme.sh --issue --dns dns_cf -d $DOMAIN --staging
    else
        ~/.acme.sh/acme.sh --issue --dns dns_cf -d $DOMAIN
    fi
    sudo mkdir /usr/local/etc/acme
    sudo chown -R $USERNAME:$USERNAME /usr/local/etc/acme
    ~/.acme.sh/acme.sh --install-cert -d $DOMAIN --key-file /usr/local/etc/acme/private.key --fullchain-file /usr/local/etc/acme/certificate.crt
    if [ $test != 1 ]
    then 
        ~/.acme.sh/acme.sh  --upgrade  --auto-upgrade
        sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/trojan-gfw/trojan-quickstart/master/trojan-quickstart.sh)"
    fi
    sudo cat > $SERVER_CONFIG_PAT << EOF
{
    "run_type": "server",
    "local_addr": "0.0.0.0",
    "local_port": 443,
    "remote_addr": "127.0.0.1",
    "remote_port": 80,
    "password": [
        "$PASSWORD"
    ],
    "log_level": 1,
    "ssl": {
        "cert": "/usr/local/etc/acme/certificate.crt",
        "key": "/usr/local/etc/acme/private.key",
        "key_password": "",
        "cipher": "ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA256",
        "prefer_server_cipher": true,
        "alpn": [
            "http/1.1"
        ],
        "reuse_session": true,
        "session_ticket": false,
        "session_timeout": 600,
        "plain_http_response": "",
        "curves": "",
        "dhparam": ""
    },
    "tcp": {
        "prefer_ipv4": false,
        "no_delay": true,
        "keep_alive": true,
        "fast_open": false,
        "fast_open_qlen": 20
    },
    "mysql": {
        "enabled": $ENABLEMYSQL,
        "server_addr": "127.0.0.1",
        "server_port": 3306,
        "database": "trojan",
        "username": "trojan",
        "password": "$MYSQLPW"
    }
}
EOF

    cat > $CLIENT_CONFIG_PAT << EOF
{
    "run_type": "client",
    "local_addr": "0.0.0.0",
    "local_port": 1080,
    "remote_addr": "$ADDRESS",
    "remote_port": 443,
    "password": [
        "$PASSWORD"
    ],
    "log_level": 1,
    "ssl": {
        "verify": true,
        "verify_hostname": true,
        "cert": "",
        "cipher": "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305-SHA256:ECDHE-RSA-CHACHA20-POLY1305-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-RSA-AES256-SHA:RSA-AES128-GCM-SHA256:RSA-AES256-GCM-SHA384:RSA-AES128-SHA:RSA-AES256-SHA:RSA-3DES-EDE-SHA",
        "sni": "$DOMAIN",
        "alpn": [
            "h2",
            "http/1.1"
        ],
        "reuse_session": true,
        "session_ticket": false,
        "curves": ""
    },
    "tcp": {
        "no_delay": true,
        "keep_alive": true,
        "fast_open": false,
        "fast_open_qlen": 20
    }
}
EOF

    if [ $NGINX == true ]
    then
        sudo apt install -y nginx
        sudo cat > $NGINX_CONFIG <<EOF
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
    worker_connections 768;
    # multi_accept on;
}

http {

    ##
    # Basic Settings
    ##

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;
    # server_tokens off;

    # server_names_hash_bucket_size 64;
    # server_name_in_redirect off;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    ##
    # SSL Settings
    ##

    ssl_protocols TLSv1 TLSv1.1 TLSv1.2; # Dropping SSLv3, ref: POODLE
    ssl_prefer_server_ciphers on;

    ##
    # Logging Settings
    ##

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    ##
    # Gzip Settings
    ##

    gzip on;
    gzip_disable "msie6";

    # gzip_vary on;
    # gzip_proxied any;
    # gzip_comp_level 6;
    # gzip_buffers 16 8k;
    # gzip_http_version 1.1;
    # gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

    ##
    # Virtual Host Configs
    ##

    #include /etc/nginx/conf.d/*.conf;
    #include /etc/nginx/sites-enabled/*;
    
    server { 
        listen 127.0.0.1:80 default_server; 

        server_name $DOMAIN;

        location / {
            proxy_pass https://$WEBSITE;
        }

    }

    server {
        listen 127.0.0.1:80;

        server_name $ADDRESS;

        return 301 https://$DOMAIN\$request_uri;
    }

    server {
        listen 0.0.0.0:80;
        listen [::]:80;

        server_name _;

        return 301 https://$DOMAIN\$request_uri;
    }
}

#mail {
#	# See sample authentication script at:
#	# http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
# 
#	# auth_http localhost/auth.php;
#	# pop3_capabilities "TOP" "USER";
#	# imap_capabilities "IMAP4rev1" "UIDPLUS";
# 
#	server {
#		listen     localhost:110;
#		protocol   pop3;
#		proxy      on;
#	}
# 
#	server {
#		listen     localhost:143;
#		protocol   imap;
#		proxy      on;
#	}
#}
EOF
    sudo systemctl enable nginx
    sudo systemctl restart nginx
    if [ $? -ne 0 ]; then
        echo "nginx 启动失败"
    else
        echo "nginx 启动成功"
    fi

    fi

    sudo systemctl enable trojan
    sudo systemctl restart trojan
    if [ $? -ne 0 ]; then
        echo "trojan 启动失败"
    else
        echo "trojan 启动成功"
    fi
}

download_client_config(){
    read -p "是否需要下载客户端配置文件(仅限xshell和SecureCRT客户端使用)输入1或者0 :" download
    if [ $download == 1 ] 
    then
        sudo sz config.json
    fi
}


install_trojan
download_client_config