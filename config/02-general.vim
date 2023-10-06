set encoding=utf-8
scriptencoding utf-8

set shortmess=It    " turn off splash screen, truncate status on buffer ops
set hidden          " enable multiple dirty buffers
set modelines=0
set number          " show line numbers
set visualbell
set wildmenu
set wildmode=longest,list
set background=dark
silent! colorscheme hybrid
" let mapleader = '\' "Set <leader> before any key remapping
set hlsearch          "highlight search results
set ignorecase        "ignore capitalization
set smartcase
set cursorline        "highlight current line
set listchars=tab:▸\ ,eol:¬
" Invisible character colors
" highlight NonText guifg=#4a4a59
" highlight SpecialKey guifg=#4a4a59
" tab settings
set expandtab
set shiftwidth=2
set softtabstop=2

set backspace=2 "set sane backspace behaviour

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

" set wildignore+=*/Deploy/*,*/node_modules/*,*/build/*,*/lib/*,*/bower_components/*,*/jspm_packages/*
set completeopt=longest,menuone,preview
set redrawtime=0
set regexpengine=2
