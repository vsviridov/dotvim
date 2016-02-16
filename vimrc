set shell=/bin/bash
scriptencoding utf-8
set encoding=utf-8
set shortmess=I "turn off splash screen

let have_plug=filereadable(expand('~/.vim/autoload/plug.vim'))
if(!have_plug && executable('curl'))
    echo "Installing Plug"

    !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

if(have_plug)
    call plug#begin('~/.vim/plugged')
    Plug 'w0ng/vim-hybrid'                  " Hybrid colorscheme
    Plug 'bling/vim-airline'                " Status bar
    Plug 'gregsexton/gitv'                  " GitK for Fugitive
    Plug 'ivyl/vim-bling'                   " blink search results
    Plug 'ctrlpvim/ctrlp.vim'               " Fuzzy search
    Plug 'majutsushi/tagbar'                " Ctags integration
    Plug 'msanders/snipmate.vim'            " Snippets
    Plug 'tommcdo/vim-lion'                 " Align stuff
    Plug 'tpope/vim-fugitive'               " Work with git repos
    Plug 'tpope/vim-surround'               " Surround with quotes
    Plug 'rking/ag.vim'                     " Silver Searcher Support
    Plug 'junegunn/rainbow_parentheses.vim' " Color matched parenthesis
                                            " Language
    Plug 'dag/vim-fish'                     " Fish Shell Support
    Plug 'tpope/vim-rails'                  " Rails integration
    Plug 'mattn/emmet-vim'                  " ZenCoding
                                            " Syntax
    Plug 'evanmiller/nginx-vim-syntax'      " Nginx Syntax
    Plug 'scrooloose/syntastic'             " Syntax checker
    Plug 'leshill/vim-json'                 " JSON support
    Plug 'slim-template/vim-slim'           " SLIM Markup Syntax
    Plug 'pangloss/vim-javascript'          " Vim Javascript support
    Plug 'kennethzfeng/vim-raml'            " RAML Bindings
    Plug 'digitaltoad/vim-jade'             " JADE bindings
    call plug#end()

    if empty(glob("~/.vim/plugged"))
        PlugInstall
    endif
endif

syntax on               "enable syntax hightlighting

set autoindent          "enable autoindent
set autoread            "automatically reload files
set encoding=utf-8      "set encoding
set hidden              "enable multiple dirty buffers
set laststatus=2        "show 2 status lines
set modelines=0
set nocompatible
set number              "show line numbers
set visualbell
set wildmenu            "show autocomplete menu
set wildmode=full

silent! colorscheme hybrid

"Set <leader> before any key remapping
let mapleader = '\'

"Javascript Function lookup
function! JsFunctionLookup()
    let l:Name = expand("<cword>")
    execute "/function ".l:Name
endfun

function! <SID>StripTrailingWhitespace()
    let pos = getpos('.')
    %s/\s\+$//e
    call setpos('.', pos)
endfun

if has("autocmd")
    filetype plugin indent on

    augroup CleanWhitespace
        au!
        autocmd BufWritePre * :call <SID>StripTrailingWhitespace()
    augroup END

    augroup InsertTimer
        au!
        "Autoexit to normal mode after 15 seconds of inactivity
        autocmd CursorHoldI * stopinsert
        autocmd InsertEnter * let updaterestore=&updatetime | set updatetime=15000
        autocmd InsertLeave * let &updatetime=updaterestore
    augroup END

    augroup vimrc
        "Automatically reload VIMRC file after saving
        au!
        autocmd bufwritepost $MYVIMRC source $MYVIMRC
    augroup END

    "Mappings for diff mode
    autocmd filterwritepre * if &diff | map <leader>{ :diffget LOCAL<cr>| endif
    autocmd filterwritepre * if &diff | map <leader>\| :diffget BASE<cr>| endif
    autocmd filterwritepre * if &diff | map <leader>} :diffget REMOTE<cr>| endif

    augroup javascript
        "Custom mappings
        au!
        autocmd FileType javascript set ai sw=2 sts=2 et
        autocmd BufRead *.js nmap <leader>f* :call JsFunctionLookup()<cr>zz
        autocmd BufRead *.js let g:syntastic_javascript_checkers = ['jshint', 'flow']
        "autocmd BufRead *.js let g:syntastic_javascript_flow_args = "--all"
    augroup END

    augroup ruby
        au!
        autocmd FileType ruby,haml,eruby,yaml,html,sass,cucumber,slim set ai sw=2 sts=2 et
        autocmd BufRead *.rb let g:syntastic_ruby_checkers = ['rubocop', 'mri']
        autocmd BufRead *.rb let g:syntastic_ruby_rubocop_exec = '/usr/bin/rubocop'
    augroup END
endif

" Set up CtrlP with faster alternative, if possible
if(executable('ag'))
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
              \ --ignore .git
              \ -g ""'
endif

"open config with \r
nmap <leader>r :e $MYVIMRC<cr>
nmap <leader>T :TagbarToggle<cr>
nmap <leader>qt :QuickfixsignsToggle<cr>
nmap <leader>qq :QuickfixsignsSet<cr>
nmap <silent><leader>w :up<cr>
imap <silent><leader>w <Esc>:up<cr>a

"Remove search highlight when <Esc> is pressed
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>
"highlight search results
set hlsearch
"ignore capitalization
set ignorecase
set smartcase
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

noremap <silent> <leader>R :! echo reload \| nc localhost 32000<cr><cr>
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
    "set guifont=Consolas:h10:cRUSSIAN,Lucida\ Console:h10:cRUSSIAN
    if has("win32")
        set guifont=Menlo_for_Powerline:h10:cANSI
    endif
else
    let g:Powerline_symbols = 'fancy'
    let g:airline_powerline_fonts = 1
    set mouse=a
endif


"Powerline fonts for Airline
let g:airline#extensions#tabline#enabled = 1

if exists("g:loaded_syntastic_checker")
    nmap <leader>c :SyntasticCheck<cr>
    nmap <leader>e :Errors<cr>
endif

nmap <leader>] :bn<cr>
nmap <leader>[ :bp<cr>
nmap <leader>d :bd<cr>

set wildignore+=*/Deploy/*,*/node_modules/*,*/build/*,*/lib/*,*/bower_components/*

set completeopt=longest,menu,menuone

