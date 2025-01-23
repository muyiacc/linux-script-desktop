#!/bin/bash

# 定义PM2的安装路径
PM2_PATH="$HOME/.npm-global/bin/pm2"

# 定义应用程序名称和启动命令
declare -A APPS
APPS[alist]="$HOME/domains/alist/alist -- server --data $HOME/domains/alist/data"
APPS[cloudflared]="$HOME/domains/cloudflared/cloudflared -- tunnel --edge-ip-version auto --protocol http2 --heartbeat-interval 10s run --token eyJhIjoiZDA1NDA5ZmU1MWYwOTZiYjE2YjgwMWI4M2NiMmVhZDYiLCJ0IjoiMDU3MWZlYjctYWM4Ny00MzhiLTk2ODAtMWFmNzJmMmIxYzgxIiwicyI6Ik1EZzNZMkprT0dFdE1UYzJOUzAwTkRCaUxXSXdNV0l0WmpFMk1qazROVEEzWXpGaCJ9"

# 函数：检查并启动应用程序
check_and_start_app() {
    local app_name=$1
    local app_cmd=$2

    # 检查指定的应用程序是否在 PM2 中运行
    if ! $PM2_PATH list | grep -q "$app_name.*online"; then
        echo "$app_name is not running, starting $app_name..."
        $PM2_PATH start $app_cmd
        if [ $? -eq 0 ]; then
            echo "$app_name started successfully."
        else
            echo "Failed to start $app_name."
        fi
    else
        echo "$app_name is already running."
    fi
}

# 函数：检查PM2是否在运行，并在必要时启动
check_pm2() {
    if ! $PM2_PATH list > /dev/null 2>&1; then
        echo "PM2 is not running, starting PM2..."
        $PM2_PATH start || $PM2_PATH resurrect
        if [ $? -eq 0 ]; then
            echo "PM2 started or resurrected successfully."
        else
            echo "Failed to start or resurrect PM2."
            exit 1
        fi
    else
        echo "PM2 is already running."
    fi
}

# 主逻辑
check_pm2

# 遍历所有应用程序并调用函数
for app_name in "${!APPS[@]}"; do
    check_and_start_app "$app_name" "${APPS[$app_name]}"
done