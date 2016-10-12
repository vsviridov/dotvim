scriptencoding utf-8
set encoding=utf-8
set shortmess=I "turn off splash screen

let vim_files=fnamemodify(resolve(expand("$MYVIMRC")), ":p:h")
let plug_path=expand(vim_files . '/autoload/plug.vim')
let have_plug=filereadable(plug_path)
if(!have_plug && executable('curl'))
    echo "Installing Plug"

    execute '!curl -fLo "' . plug_path . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

if(have_plug)
    call plug#begin(vim_files . '/plugged')
    Plug 'tpope/vim-sensible'               " Sensible defaults for vim
    Plug 'w0ng/vim-hybrid'                  " Hybrid colorscheme
    Plug 'vim-airline/vim-airline'          " Status bar
    Plug 'vim-airline/vim-airline-themes'   " Status bar themes
    Plug 'gregsexton/gitv'                  " GitK for Fugitive
    Plug 'ivyl/vim-bling'                   " blink search results
    Plug 'ctrlpvim/ctrlp.vim'               " Fuzzy search
    Plug 'majutsushi/tagbar'                " Ctags integration
    Plug 'marcweber/vim-addon-mw-utils' |
        Plug 'tomtom/tlib_vim' |
        Plug 'garbas/vim-snipmate'          " Snippets
    Plug 'honza/vim-snippets'               " Default snippet collection
    Plug 'tommcdo/vim-lion'                 " Align stuff
    Plug 'tpope/vim-fugitive'               " Work with git repos
    Plug 'tpope/vim-surround'               " Surround with quotes
    Plug 'rking/ag.vim'                     " Silver Searcher Support
    Plug 'tpope/vim-commentary'             " Commenting
    Plug 'mtth/scratch.vim'                 " Scratch Buffer

    " Language
    Plug 'dag/vim-fish'                     " Fish Shell Support
    Plug 'tpope/vim-rails'                  " Rails integration
    Plug 'mattn/emmet-vim'                  " ZenCoding
    Plug 'sheerun/vim-polyglot'             " Language Support Bundle

    if version >= 800
        Plug 'maralla/validator.vim'        " Async syntax checker
        Plug 'maralla/completor.vim', { 'do': 'make js' }        " Code completion
    endif
    call plug#end()

    if empty(glob(vim_files . '/plugged'))
        PlugInstall
    endif
endif

set hidden              "enable multiple dirty buffers
set modelines=0
set nocompatible
set number              "show line numbers
set visualbell
set wildmode=full

set background=dark
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
        autocmd BufRead *.js,*.jsx let g:syntastic_javascript_checkers = ['eslint']
        map <leader>jj :set ft=javascript.jsx<cr>
    augroup END

    augroup ruby
        au!
        autocmd FileType ruby,haml,eruby,yaml,html,sass,cucumber,slim set ai sw=2 sts=2 et
        autocmd BufRead *.rb let g:syntastic_ruby_checkers = ['rubocop', 'mri']
        autocmd BufRead *.rb let g:syntastic_ruby_rubocop_exec = '/usr/bin/rubocop'
    augroup END

    augroup html
        au!
        au BufNewFile,BufRead *.ejs set filetype=html
        autocmd FileType html call SetHtmlOptions()
        function! SetHtmlOptions()
          if(executable('tidy'))
            let g:syntastic_html_tidy_ignore_errors = [ '<meta> proprietary attribute "property"', '<html> proprietary attribute "prefix"', 'trimming empty <span>', 'trimming empty <i>', '<script> proprietary attribute "integrity"', '<link> proprietary attribute "integrity"', '<link> proprietary attribute "crossorigin"', '<script> proprietary attribute "crossorigin"']
          endif
        endfunction
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
cmap w!! w !sudo tee % >/dev/null

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
nmap <leader>] :bn<cr>
nmap <leader>[ :bp<cr>
nmap <leader>d :bd<cr>

if($ConEmuANSI == 'ON' && !has("gui_running"))
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    inoremap <Esc>[62~ <C-X><C-E>
    inoremap <Esc>[63~ <C-X><C-Y>
    nnoremap <Esc>[62~ <C-E>
    nnoremap <Esc>[63~ <C-Y>
endif

if has("gui_running")
    set go-=mTr " disable toolbar, menubar and scrollbar
    if has("win32")
        set guifont=Source_Code_Pro:h12:cANSI
    endif
    if has("osx")
       set guifont=Source_Code_Pro:h13
    endif
else
    set mouse=a
endif

silent! colorscheme hybrid
set background=dark
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:validator_javascript_checkers = ['eslint']
let g:validator_filetype_map = { "jsx": "javascript", "javascript.jsx": "javascript" }
let g:validator_permament_sign = 1


if exists("g:loaded_syntastic_checker")
    nmap <leader>c :SyntasticCheck<cr>
    nmap <leader>e :Errors<cr>
endif

nmap <leader>] :bn<cr>
nmap <leader>[ :bp<cr>
nmap <leader>d :bd<cr>

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

set wildignore+=*/Deploy/*,*/node_modules/*,*/build/*,*/lib/*,*/bower_components/*,*/jspm_packages/*
set completeopt=longest,menu,menuone
