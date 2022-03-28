#!/bin/bash
WORK_PATH='/usr/qunqunprojects/qunqun-node'
cd $WORK_PATH
echo "先清除老代码"
git reset --hard origin/master
git clean -f
echo "拉取最新代码"
git pull origin master
echo "开始执行构建"
docker build -t qunqun-node:1.0 .
echo "停止旧容器并删除旧容器"
docker stop qunqun-node-container
docker rm qunqun-node-container
echo "启动新容器"
docker container run -p 3002:3002 --name qunqun-node-container -d qunqun-node:1.0