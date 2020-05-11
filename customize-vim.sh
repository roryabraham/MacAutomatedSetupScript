#!/usr/bin/env bash

# import shared functions
source ./shared-functions.sh
if ["$?" != "0"]
then echo "Error importing shared functions.\n" && exit 1
fi

# Install latest vim
echo "\n\nInstalling latest version of vim...\n"
brew install vim --with-override-system-vi

# Install pathogen-vim
echo "\n\nInstalling pathogen-vim...\n"
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install gruvbox (my vim colorscheme of choice)
echo "\n\nInstalling gruvbox color scheme...\n"
mkdir -p ~/.vim/colors/
echo "\nAttempting to download theme...\n"
curl -fsSL \
    https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim \
    --output ~/.vim/colors/gruvbox.vim
report_install_success "gruvbox vim theme"
# Next, dump .vimrc
echo $(cat ./.vimrc_content) >> ~/.vimrc
