#!/bin/bash

rclone mount --buffer-size 4M --vfs-cache-mode writes alist: /mnt/alist --daemon
