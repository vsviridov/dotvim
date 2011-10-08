call pathogen#infect()
syntax on
filetype plugin indent on
set laststatus=2
set statusline=%t\ %y\ format:\ %{&ff};\ [%c,%l]
set number
set autoindent
set hidden
colorscheme darkblue
if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
endif
