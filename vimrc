set shell=/bin/bash
scriptencoding utf-8
set encoding=utf-8

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

    "Mappings for diff mode
    autocmd filterwritepre * if &diff | map <leader>{ :diffget \\2<cr>| endif
    autocmd filterwritepre * if &diff | map <leader>} :diffget \\3<cr>| endif
endif
"Set <leader> before any key remapping
let mapleader = '\'
"open config with \r
nmap <leader>r :e $MYVIMRC<cr>
nmap <leader>T :TagbarToggle<cr>
nmap <silent><leader>w :up<cr>
imap <silent><leader>w <Esc>:up<cr>a

"Javascript Function lookup
function! JsFunctionLookup()
    let l:Name = expand("<cword>")
    execute "/function ".l:Name
endfu
nmap <leader>f* :call JsFunctionLookup()<cr>zz

"Remove search highlight when <Esc> is pressed
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>
"highlight search results
set hlsearch
"highlight current line
set cursorline
"show whitespace
"set list
set listchars=tab:▸\ ,eol:¬
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

"toggle whitespace
nmap <leader>l :set list!<cr>

"tab settings
set shiftwidth=4
set tabstop=4
set expandtab

"set sane backspace behaviour
set backspace=2

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
"press space in normal mode to center screen
nmap <space> zz

if has("gui_running")
	set guifont=Consolas:h10:cRUSSIAN,Lucida\ Console:h10:cRUSSIAN
	"set guifont=Menlo_for_Powerline:h10:cANSI
else
	"let g:Powerline_symbols = 'fancy'
    set mouse=a
endif	

"Powerline fonts for Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

if exists("g:loaded_syntastic_c_autoload")
	nmap <leader>c :SyntasticCheck<cr>
	nmap <leader>e :Errors<cr>
endif

nmap <leader>] :bn<cr>
nmap <leader>[ :bp<cr>

if(has("win32") || has("win16"))
    set wildignore+=*/Deploy/*,*/node_modules/*,*/build/*
else
    set wildignore+=*\Deploy\*,*\node_modules\*,*\build\*
endif
