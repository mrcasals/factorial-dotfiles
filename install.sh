#!/bin/bash

# Install chezmoi if it doesn't exist so that we can actually install dotfiles
[[ ! -f ~/bin/chezmoi ]] && sh -c "$(curl -fsLS chezmoi.io/get)"

# Install some deps if they're not there
if ! command -v nvim &> /dev/null
then
  sudo add-apt-repository -y ppa:neovim-ppa/unstable
  sudo add-apt-repository -y ppa:aos1/diff-so-fancy
  sudo apt-get update -qq && \
  sudo apt-get install -o Dpkg::Options::=--force-confdef -yq --no-install-recommends \
  diff-so-fancy \
  neovim \
  tmux \
  tmuxinator && \
  sudo apt-get install -y -o Dpkg::Options::="--force-overwrite" \
  bat \
  zstd \
  ripgrep && \
  sudo rm -rf /var/lib/apt/lists/*
fi

~/bin/chezmoi init

pushd ~/.local/share/chezmoi
  git remote add origin $SUPERVISOR_DOTFILE_REPO
  git branch -M main
  git pull origin main
popd

~/bin/chezmoi apply

source ~/.bashrc

# Install packer dependencies
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' & disown
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' & disown # Yep, twice
nvim --headless -c 'TSUpdateSync' & disown
