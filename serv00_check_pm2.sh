#!/bin/bash

# 定义PM2的安装路径
PM2_PATH="$HOME/.npm-global/bin/pm2"

# 定义应用程序名称和路径
APP_NAME1="alist"
APP_CMD1="$HOME/domains/alist/alist -- server --data $HOME/domains/alist/data"

APP_NAME2="cloudflared"
APP_CMD2="$HOME/domains/cloudflared/cloudflared -- tunnel --edge-ip-version auto --protocol http2 --heartbeat-interval 10s run --token eyJhIjoiZDA1NDA5ZmU1MWYwOTZiYjE2YjgwMWI4M2NiMmVhZDYiLCJ0IjoiMDU3MWZlYjctYWM4Ny00MzhiLTk2ODAtMWFmNzJmMmIxYzgxIiwicyI6Ik1EZzNZMkprT0dFdE1UYzJOUzAwTkRCaUxXSXdNV0l0WmpFMk1qazROVEEzWXpGaCJ9"

# 检查PM2是否在运行
pm2_status=$(pm2 status)
if [ -z "$pm2_status" ]; then
    echo "PM2 is not running, starting PM2..."
    $PM2_PATH start || $PM2_PATH resurrect
    if [ $? -eq 0 ]; then
        echo "PM2 started or resurrected successfully."
    else
        echo "Failed to start or resurrect PM2."
        exit 1
    fi
else
    echo "PM2 is running."
fi

# 检查app1是否存活
if ! $PM2_PATH list | grep -q "$APP_NAME1"; then
    echo "$APP_NAME1 is not running, starting $APP_NAME1..."
    $PM2_PATH start $APP_CMD1
    if [ $? -eq 0 ]; then
        echo "$APP_NAME1 started successfully."
    else
        echo "Failed to start $APP_NAME1."
    fi
else
    echo "$APP_NAME1 is running."
fi

# 检查app2是否存活
if ! $PM2_PATH list | grep -q "$APP_NAME2"; then
    echo "$APP_NAME2 is not running, starting $APP_NAME2..."
    $PM2_PATH start $APP_CMD2
    if [ $? -eq 0 ]; then
        echo "$APP_NAME2 started successfully."
    else
        echo "Failed to start $APP_NAME2."
    fi
else
    echo "$APP_NAME2 is running."
fi

# 保存PM2的进程列表
$PM2_PATH save