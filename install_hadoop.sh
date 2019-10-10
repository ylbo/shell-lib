#!/bin/bash

yum install java-1.8.0-openjdk-devel-1.8.0.222.b10-0.el6_10 -y
wget https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz
tar -zxf hadoop-2.7.7.tar.gz -C /usr/local/
mv /usr/local/hadoop-2.7.7 /usr/local/hadoop
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-0.el6_10.x86_64/jre" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME:\$PATH" >> ~/.bashrc
echo "export HADOOP_HOME=/usr/local/hadoop/" >> ~/.bashrc
echo "export PATH=\$HADOOP_HOME/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc

