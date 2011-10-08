call pathogen#infect()
syntax on
set laststatus=2
set statusline=%t\ %y\ format:\ %{&ff};\ [%c,%l] %{fugitive#statusline()}
set number
set autoindent
set hidden
colorscheme default
if has("autocmd")
	autocmd bufwritepost vimrc source $MYVIMRC
endif
