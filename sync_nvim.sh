#/bin/bash
rsync -azvP --delete --exclude='*.lock' --exclude='*.swp' --exclude='*.bak' \
    ~/.config/nvim \
    ~/backup/linux-desktop/dotfiles/nvim
