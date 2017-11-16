set shortmess=I     " turn off splash screen
set hidden          " enable multiple dirty buffers
set modelines=0
set nocompatible
set number          " show line numbers
set visualbell
set wildmode=full
set background=dark
silent! colorscheme hybrid
" let mapleader = '\' "Set <leader> before any key remapping
set hlsearch        "highlight search results
set ignorecase      "ignore capitalization
set smartcase
set cursorline      "highlight current line
set listchars=tab:▸\ ,eol:¬
                    "Invisible character colors
" highlight NonText guifg=#4a4a59
" highlight SpecialKey guifg=#4a4a59
"tab settings
set expandtab
set shiftwidth=4
set softtabstop=4

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
set completeopt=longest,menu,menuone

" Stolen from maralla/dotvim
function! EnsureExists(path) abort
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path))
    endif
endfunction

" persistent undo
if exists('+undofile')
    set undofile
    set undodir=~/.vim/.cache/undo
endif

" backups
set backup
set backupdir=~/.vim/.cache/backup

" swap files
set directory=~/.vim/.cache/swap
set noswapfile

call EnsureExists('~/.vim/.cache')
call EnsureExists(&undodir)
call EnsureExists(&backupdir)
call EnsureExists(&directory)
