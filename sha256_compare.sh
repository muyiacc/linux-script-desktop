#!/bin/bash

script_name=$(basename "$0")

# 帮助函数
show_help() {
    echo "用法: $script_name <下载文件> <期望的SHA256哈希值>"
    echo "比较给定文件的SHA256哈希值和期望的哈希值，判断文件是否被篡改。"
}

# 参数验证
if [ "$1" = "-h" ]; then
    show_help
    exit 0
fi

if [ $# -ne 2 ]; then
    echo "错误：需要提供两个参数。"
    show_help
    exit 1
fi

# 获取文件路径和给定的 SHA256 值
downloaded_file=$1
expected_hash=$2

# 检查文件是否存在
if [ ! -f "$downloaded_file" ]; then
    echo "错误：文件 '$downloaded_file' 不存在。"
    exit 1
fi

# 计算下载文件的 SHA256 值
calculated_hash=$(sha256sum "$downloaded_file" | awk '{print $1}')

# 比对计算得到的哈希值和给定的哈希值
if [ "$calculated_hash" = "$expected_hash" ]; then
    echo "哈希值匹配，文件未被篡改。"
else
    echo "哈希值不匹配，文件可能已被篡改。"
fi
