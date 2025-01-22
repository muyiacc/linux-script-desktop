#/bin/bash
rsync -av --exclude='*.lock' --exclude='*.swp' --exclude='*.bak' \
    ~/.config/nvim \
    ~/backup/linux-desktop/dotfiles/nvim
