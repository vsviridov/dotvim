set encoding=utf-8
scriptencoding utf-8

set shortmess=I     " turn off splash screen
set hidden          " enable multiple dirty buffers
set modelines=0
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

 " Set up CtrlP with faster alternative, if possible
 if executable('ag')
     " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
     set grepprg=ag\ --nogroup\ --nocolor
     " Use ag in CtrlP for listing files. Lightning fast, respects .gitignore
     " and .agignore. Ignores hidden files by default.
     let g:ctrlp_user_command = 'ag %s -l --nocolor -f -g ""'
     let g:ctrlp_use_caching = 0
 else
     if executable('rg')
         set grepprg=rg\ --color=never

         let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
         let g:ctrlp_use_caching = 0
     else
         "ctrl+p ignore files in .gitignore
         let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
     endif
 endif

 if has('gui_running')
     set guioptions-=mTr " disable toolbar, menubar and scrollbar
     if has('win32')
         set guifont=Source_Code_Pro:h12:cANSI
     endif
     if has('osx')
         set guifont=Source_Code_Pro:h13
     endif
 else
     if(has('mouse'))
         set mouse=a
     endif
     if $TERM_PROGRAM ==? 'iTerm.app'
         " different cursors for insert vs normal mode
         if exists('$TMUX')
             let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
             let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
         else
             let &t_SI = "\<Esc>]50;CursorShape=1\x7"
             let &t_EI = "\<Esc>]50;CursorShape=0\x7"
         endif
     endif

     " Windows-specific setting allowing for 256-colors etc
     if($ConEmuANSI ==? 'ON')
         set term=xterm
         set t_Co=256
         let &t_AB='\e[48;5;%dm'       " background color
         let &t_AF='\e[38;5;%dm'       " foreground color
         inoremap <Esc>[62~ <C-X><C-E>
         inoremap <Esc>[63~ <C-X><C-Y>
         nnoremap <Esc>[62~ <C-E>
         nnoremap <Esc>[63~ <C-Y>
     endif
 endif
