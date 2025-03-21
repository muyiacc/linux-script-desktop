#!/bin/bash

source_dirs=(
  ~/.config/hypr
  ~/.config/waybar
  ~/.config/dconf
  ~/.config/pulse
  ~/.config/kitty
  ~/.config/rofi
)
dest_dir="$HOME/backup/archlinux/dotfiles/hyprland"
exclude_params=(
  *.bak
  *.swp
  *.lock
)

for source_dir in "${source_dirs[@]}"; do
  if [ -d "$source_dir" ]; then
    echo "$source_dir found"
  else
    echo "$source_dir not found"
  fi
done

if [ ! -d "$dest_dir" ]; then
  echo "mkdir $dest_dir"
  mkdir -p "$dest_dir"
fi

for source_dir in "${source_dirs[@]}"; do
  echo "===== start sync ======"
  echo ""
  dir_name=$(basename "$source_dir")
  target_dir="$dest_dir/$dir_name"
  
  rsync_args=()
  for exclude_param in "${exclude_params[@]}"; do
    rsync_args+=("--exclude=$exclude_param")
  done

  rsync -azP --delete "${rsync_args[@]}" "$source_dir/" "$target_dir"

  # if [ $? -eq 0 ]; then
  #   echo "$dir_name synced"
  # else
  #   echo "$dir_name sync failed"
  # fi
done
