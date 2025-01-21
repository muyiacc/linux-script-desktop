#!/bin/bash

# 定义分区的 UUID 和挂载点
declare -A mounts
mounts["8EB8092DB80914FD"]="/mnt/c"
mounts["4CAE454BAE452EB0"]="/mnt/d"
mounts["5CA2CB81A2CB5E60"]="/mnt/e"
mounts["84E0D3E7E0D3DD8C"]="/mnt/f"

# 定义文件系统类型和 mount 命令选项
fs_type="ntfs-3g"
options="defaults"

# 遍历所有定义的 UUID 和挂载点
for uuid in "${!mounts[@]}"; do
  mount_point="${mounts[$uuid]}"

  # 检查挂载点是否存在
  if [ ! -d "$mount_point" ]; then
    echo "Creating mount point: $mount_point"
    sudo mkdir -p "$mount_point"
  fi

  # 检查是否已经挂载
  if ! grep -qs "$mount_point" /proc/mounts; then
    echo "Mounting UUID $uuid to $mount_point"
    # 执行挂载命令
    sudo mount -t "$fs_type" -o "$options" "UUID=$uuid" "$mount_point"
  else
    echo "$mount_point is already mounted."
  fi
done

echo "Script completed."
