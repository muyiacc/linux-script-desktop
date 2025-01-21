#/bin/bash
sync -av --exclude='*.lock' --exclude='*.swp' --exclude='*.bak' \
    ~/.config/nvim \
    ~/backup/linux-desktop/dotfile/nvim
