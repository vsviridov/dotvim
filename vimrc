call pathogen#infect()
syntax on			"enable syntax hightlighting

set nocompatible
set modelines=0
set visualbell
set laststatus=2		"show 2 status lines
set number			"show line numbers
set autoindent			"enable autoindent
set hidden			"enable multiple dirty buffers
set encoding=utf-8		"set encoding 
set autoread			"automatically reload files

colorscheme hybrid

if has("autocmd")
	"Autoexit to normal mode after 15 seconds of inactivity
	autocmd CursorHoldI * stopinsert
	autocmd InsertEnter * let updaterestore=&updatetime | set updatetime=15000
	autocmd InsertLeave * let &updatetime=updaterestore
	"Automatically reload VIMRC file after saving
	autocmd bufwritepost .vimrc source $MYVIMRC
	autocmd bufwritepost _vimrc source $MYVIMRC
endif
"Set <leader> before any key remapping
let mapleader = '\'

"Remove search highlight when <Esc> is pressed
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>
"highlight search results
set hlsearch

"No more arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>

"move up and down within virtual lines
nnoremap j gj
nnoremap k gk

"press jk in quick succession for esc key
imap jk <Esc>

if has("gui_running")
	set guifont=Lucida\ Console:h10:cRUSSIAN
else
	let g:Powerline_symbols = 'fancy'
endif	
