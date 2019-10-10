#!/bin/bash
CONFIGNAME=$1
IP=$2
GATEWAY=$3
if [ -n "$4" ]
then
    DNS1=$4
else
    DNS1=$GATEWAY
fi

if [ -n "$5" ]
then
    PREFIX=$5
else
    PREFIX=24
fi

CONFIGPATH="/etc/sysconfig/network-scripts/ifcfg-eth$CONFIGNAME"
sed -i "s/^IPADDR.*$/IPADDR=$IP/g" $CONFIGPATH
sed -i "s/^PREFIX.*$/PREFIX=$PREFIX/g" $CONFIGPATH
sed -i "s/^GATEWAY.*$/GATEWAY=$GATEWAY/g" $CONFIGPATH
sed -i "s/^DNS1.*$/DNS1=$DNS1/g" $CONFIGPATH
 
service network restart