#!/bin/bash

rclone mount --buffer-size 4M --vfs-cache-mode writes alist_remote: /mnt/alist_remote --daemon
