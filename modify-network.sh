#!/bin/bash
CONFIGNAME=$1
IP=$2
GATEWAY=$3

if [ -n "$4" ]
then
    ETHNUMBER=$4
else
    ETHNUMBER=0
fi

if [ -n "$5" ]
then
    DNS1=$5
else
    DNS1=$GATEWAY
fi

if [ -n "$6" ]
then
    PREFIX=$6
else
    PREFIX=24
fi

CONFIGPATH="/etc/sysconfig/network-scripts/ifcfg-eth$CONFIGNAME"

sed -i "s/^DEVICE.*$/DEVICE=\"eth$ETHNUMBER\"/g" $CONFIGPATH
sed -i "s/^BOOTPROTO.*$/BOOTPROTO=\"static\"/g" $CONFIGPATH
sed -i "s/^IPADDR.*$/IPADDR=$IP/g" $CONFIGPATH
sed -i "s/^PREFIX.*$/PREFIX=$PREFIX/g" $CONFIGPATH
sed -i "s/^GATEWAY.*$/GATEWAY=$GATEWAY/g" $CONFIGPATH
sed -i "s/^DNS1.*$/DNS1=$DNS1/g" $CONFIGPATH
 
service network restart