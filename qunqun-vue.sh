#!/bin/bash
WORK_PATH='/usr/qunqunprojects/qunqun-vue'
cd $WORK_PATH
echo "先清除老代码"
git reset --hard origin/master
git clean -f
echo "拉取最新代码"
git pull origin master
echo "编译"
npm run build:prod
echo "开始执行构建"
docker build -t qunqun-vue:1.0 .
echo "停止旧容器并删除旧容器"
docker stop qunqun-vue-container
docker rm qunqun-vue-container
echo "启动新容器"
docker container run -p 8081:8081 --name qunqun-vue-container -d qunqun-vue:1.0