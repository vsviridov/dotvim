#!/bin/bash

ln -s ~/.vim/vimrc ~/.vimrc
cd ~/.vim
git submodule update --recursive --init
