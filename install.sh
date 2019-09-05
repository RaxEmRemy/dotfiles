#!/bin/sh
# This script installs my dotfiles + some extras into any apt-based *nix system.

install_devtools () {
    # Install pre-reqs/dev-tools
    sudo apt update && sudo apt install -y \
    tmux \
    vim \
    git \
    curl \
    htop \
    ncdu \
    net-tools \
    python3 \
    virtualenv \
    shellcheck \
    python3-pip

    # Install linters
    sudo pip3 install pylint
}

install_dotfiles () {
    # Rename old dotfiles and preserve them, if applicable.
    mkdir ~/.dotfiles_old
    cp -av ~/.vim ~/.dotfiles_old/.vim
    cp -av ~/.vimrc ~/.dotfiles_old/.vimrc
    cp -av ~/.tmux.conf ~/.dotfiles_old/.tmux.conf
    cp -av ~/.fonts ~/.dotfiles_old/.fonts.old
    cp -av ~/.bashrc ~/.dotfiles_old/.bashrc
    cp -av ~/.Xresources ~/.dotfiles_old/.Xresources
    cp -av ~/.bash_aliases ~/.dotfiles_old/.bash_aliases

    # Symlink new dotfiles into user home dir
    ln -fnvs "$(pwd)"/.vim ~/.vim
    ln -fnvs "$(pwd)"/.vimrc ~/.vimrc
    ln -fnvs "$(pwd)"/.tmux.conf ~/.tmux.conf
    ln -fnvs "$(pwd)"/.bashrc ~/.bashrc
    ln -fnvs "$(pwd)"/.Xresources ~/.Xresources
    ln -fnvs "$(pwd)"/.bash_aliases ~/.bash_aliases
    ln -fnvs "$(pwd)"/polybar/config ~/.config/polybar/config
    ln -fnvs "$(pwd)"/i3/config ~/.config/i3/config
}

if [ "$1" = "minimal" ]
then
    install_dotfiles
else
    install_devtools
    install_dotfiles
fi
