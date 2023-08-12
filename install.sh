#!/bin/bash

NVIM_DIR="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config/nvim-backup"
CLONE_NVM_DIR="$(pwd)/nvim"
PACKER_PATH="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

if [ -d "$NVIM_DIR" ]; then
    mv "$NVIM_DIR" "$BACKUP_DIR"
fi

cp -r "$CLONE_NVM_DIR" "$NVIM_DIR"

echo "where packer at"
if ! nvim --headless +PackerSync +qall &>/dev/null; then
    echo "no packer yikes"
    rm -rf "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        "$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
else
    echo "packer gucci"
fi

