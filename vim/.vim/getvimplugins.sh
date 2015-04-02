#!/bin/bash

# ========================================================= #
# getvimplugins                                             #
# Created by: spcmd                                         #
# Website: http://spcmd.github.io                           #
#          https://github.com/spcmd                         #
#          https://gist.github.com/spcmd                    #
# ========================================================= #

# Copy this script to your VIM directory and run it from there
# cd ~/.vim
# ./getvimplugins.sh

# Set the directories
VIM_AUTOLOAD_DIR=autoload
VIM_BUNDLE_DIR=bundle

# Create the directories
mkdir -p $VIM_AUTOLOAD_DIR $VIM_BUNDLE_DIR

# Install Pathogen
git clone https://github.com/tpope/vim-pathogen.git
mv vim-pathogen/autoload/pathogen.vim $VIM_AUTOLOAD_DIR
echo "pathogen.vim moved to: $VIM_AUTOLOAD_DIR"
rm -rf vim-pathogen
echo "vim-pathogen directory removed, not needed anymore."
# Vim-Airline
git clone https://github.com/bling/vim-airline
mv vim-airline $VIM_BUNDLE_DIR
echo "vim-airline moved to: $VIM_BUNDLE_DIR"
# NERDTree
git clone https://github.com/scrooloose/nerdtree.git
mv nerdtree $VIM_BUNDLE_DIR
echo "nerdtree moved to: $VIM_BUNDLE_DIR"
# Emmet-Vim
git clone https://github.com/mattn/emmet-vim.git
mv emmet-vim $VIM_BUNDLE_DIR
echo "emmet-vim moved to: $VIM_BUNDLE_DIR"
# Multiple cursors
git clone https://github.com/terryma/vim-multiple-cursors.git
mv vim-multiple-cursors $VIM_BUNDLE_DIR
echo "vim-multiple-cursors moved to: $VIM_BUNDLE_DIR"
# nerdcommenter
git clone https://github.com/scrooloose/nerdcommenter.git
mv nerdcommenter $VIM_BUNDLE_DIR
echo "nerdcommenter moved to: $VIM_BUNDLE_DIR"
# Spacegray color scheme
git clone git://github.com/ajh17/Spacegray.vim.git
mv Spacegray.vim $VIM_BUNDLE_DIR
echo "Spacegray.vim moved to: $VIM_BUNDLE_DIR"
# vim-misc (needed for vim-session)
git clone https://github.com/xolox/vim-misc.git
mv vim-misc $VIM_BUNDLE_DIR
echo "vim-misc moved to: $VIM_BUNDLE_DIR"
# vim-session
git clone https://github.com/xolox/vim-session.git
mv vim-session $VIM_BUNDLE_DIR
echo "vim-session moved to: $VIM_BUNDLE_DIR"

# YouCompleteMe plugin have some dependencies, so it's better to install it manually
echo "YouCompleteMe isn't installed automatically. This bundle have some dependencies, so please visit https://github.com/Valloric/YouCompleteMe or http://valloric.github.io/YouCompleteMe for more information, and install it manually."
# Patched powerline fonts needed, but you might have it, so not need to install automatically
echo "Powerline fonts aren't installed automatically. If you don't have it already installed, please visit: https://github.com/powerline/fonts and install it manually. Then select one of the installed powerline font type in the terminal settings, and also set this font type in your vimrc to use with GVIM."
