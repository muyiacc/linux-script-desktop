#!/bin/bash

# 定义一个函数，用于简化 apt 命令的使用
function myapt() {
    local command=$1
    shift # 移除第一个参数，剩下的参数将作为包名或其他参数

    case "$command" in
        install|i)
            sudo apt-get install -y "$@"
            ;;
        remove|r)
            sudo apt-get remove -y "$@"
            ;;
        purge)
            sudo apt-get purge -y "$@"
            ;;
        autoremove)
            sudo apt-get autoremove -y
            ;;
        update|u)
            sudo apt-get update
            ;;
        upgrade|up)
            sudo apt-get upgrade -y
            ;;
        search)
            apt-cache search "$@"
            ;;
        show)
            apt-cache show "$@"
            ;;
        list)
            apt list "$@"
            ;;
        check)
            sudo apt check
            ;;
        clean)
            sudo apt clean
            ;;
        autoclean)
            sudo apt autoclean
            ;;
        *)
            echo "Unknown command: $command"
            echo "Usage: myapt {install|remove|purge|autoremove|update|upgrade|search|show|list|check|clean|autoclean}"
            return 1
            ;;
    esac
}

# 检查是否提供了命令
if [ $# -eq 0 ]; then
    echo "No command provided."
    echo "Usage: myapt {install|remove|purge|autoremove|update|upgrade|search|show|list|check|clean|autoclean} [package ...]"
    exit 1
fi

# 调用 myapt 函数
myapt "$@"