#!/bin/bash

# 定义源目录和目标目录
SOURCE_DIR="$HOME/Downloads"
TARGET_DIR="$HOME/software/debian"

# 检查目标目录是否存在，如果不存在则创建它
if [ ! -d "$TARGET_DIR" ]; then
    mkdir -p "$TARGET_DIR"
fi

# 定义要处理的文件扩展名
declare -a FILE_EXTENSIONS=(".deb" ".AppImage")

# 移动所有指定扩展名的文件到目标目录，并在有同名文件时弹出对话框让用户选择
for ext in "${FILE_EXTENSIONS[@]}"; do
    # 找到所有具有当前扩展名的文件
    for file in "$SOURCE_DIR"/*"$ext"; do
        if [ -e "$file" ]; then
            base_name=$(basename "$file")
            target_file="$TARGET_DIR/$base_name"

            # 检查目标文件是否存在
            if [ -e "$target_file" ]; then
                # 使用 zenity 弹出对话框让用户选择
                choice=$(zenity --list --title="File Conflict Resolution" --column="Option" \
                    "Overwrite" \
                    "Rename" \
                    "Cancel" \
                    --width=600 --height=500 --text "文件冲突: $base_name")

                # 根据用户选择执行相应操作
                case $choice in
                    Overwrite)
                        mv "$file" "$target_file"
                        echo "文件 $file 已被覆盖到 $target_file"
                        ;;
                    Rename)
                        timestamp=$(date +"%Y%m%d%H%M%S")
                        new_name="${base_name%.*}_$timestamp.${base_name##*.}"
                        target_file="$TARGET_DIR/$new_name"
                        mv "$file" "$target_file"
                        echo "文件 $file 已移动并重命名为 $target_file"
                        ;;
                    Cancel)
                        echo "操作已取消"
                        continue 2
                        ;;
                    *)
                        echo "未知响应：$choice"
                        continue 2
                        ;;
                esac
            else
                # 如果目标文件不存在，直接移动文件
                mv "$file" "$target_file"
                echo "文件 $file 已移动到 $target_file"
            fi
        fi
    done
done