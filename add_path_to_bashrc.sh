#!/bin/bash

# 提示用户输入路径
read -p "请输入要添加到环境变量的路径: " custom_path

# 检查路径是否已经添加到~/.bashrc中
if ! grep -Fxq "export PATH=\$PATH:$custom_path" ~/.bashrc; then
    # 如果路径不存在，追加到~/.bashrc，并在之前添加一个空行
    echo "" >> ~/.bashrc  # 添加空行
    echo "export PATH=\$PATH:$custom_path" >> ~/.bashrc  # 追加export命令
    
    echo "路径已添加到~/.bashrc。"
else
    echo "路径已存在于~/.bashrc中。"
fi

# 重新加载~/.bashrc，使更改立即生效
source ~/.bashrc
