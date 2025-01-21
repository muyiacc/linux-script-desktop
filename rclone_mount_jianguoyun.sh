#/bin/bash
rclone mount --buffer-size 1M --vfs-cache-mode full jianguoyun: /mnt/jianguoyun --daemon
