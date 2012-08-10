call pathogen#infect()
syntax on
set laststatus=2
"set statusline=%t\ %y\ format:\ %{&ff};\ [%c,%l]\ %{fugitive#statusline()}
set number
set autoindent
set hidden
set encoding=utf-8
"set t_Co=256
colorscheme hybrid
if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
endif
set nocompatible
set modelines=0
set visualbell

nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

"No more arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
nnoremap j gj
nnoremap k gk
"press jk in quick succession for esc key
imap jj <Esc>

"Autoexit to normal mode
if has("autocmd")
	au CursorHoldI * stopinsert
	au InsertEnter * let updaterestore=&updatetime | set updatetime=15000
	au InsertLeave * let &updatetime=updaterestore
endif

if has("gui_running")
else
	let g:Powerline_symbols = 'fancy'
endif	

set autoread		"automatically reload files
