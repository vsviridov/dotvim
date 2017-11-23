 if has("autocmd")
     filetype plugin indent on

     augroup InvisibleCharsHighlight
         au!

         autocmd ColorScheme * :call ResetColors()

         function! ResetColors()
             "Invisible character colors
             highlight NonText guifg=#4a4a59
             highlight SpecialKey guifg=#4a4a59
         endfun
     augroup END

     augroup CleanWhitespace
         au!
         autocmd BufWritePre * :call <SID>StripTrailingWhitespace()
         function! <SID>StripTrailingWhitespace()
             let pos = getpos('.')
             %s/\s\+$//e
             call setpos('.', pos)
         endfun
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
         if (exists('g:loaded_airline') && g:loaded_airline)
             autocmd bufwritepost $MYVIMRC AirlineRefresh
         endif
     augroup END

     augroup diffmode
         au!
         " Mappings for diff mode
         autocmd filterwritepre * if &diff | map <leader>{ :diffget LOCAL<cr>| endif
         autocmd filterwritepre * if &diff | map <leader>\| :diffget BASE<cr>| endif
         autocmd filterwritepre * if &diff | map <leader>} :diffget REMOTE<cr>| endif
     augroup END

     augroup javascript
         "Custom mappings
         au!
         autocmd FileType javascript set ai sw=2 sts=2 et

         "Javascript Function lookup
         function! JsFunctionLookup()
             let l:Name = expand("<cword>")
             execute "/function ".l:Name
         endfun

         " autocmd FileType javascript map <leader>jj :set ft=javascript.jsx<cr>
         " autocmd BufRead *.js nmap <leader>f* :call JsFunctionLookup()<cr>zz
         " autocmd BufRead *.js,*.jsx let g:syntastic_javascript_checkers = ['eslint']
         " autocmd BufWritePre *.js Neoformat
         let g:neoformat_javascript_prettier = {
                     \ 'exe' : 'prettier',
                     \ 'args': ['--stdin', '--trailing-comma=es5', '--single-quote'],
                     \ 'stdin': 1
                     \ }
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
                 let g:syntastic_html_tidy_ignore_errors = [
                             \'<meta> proprietary attribute "property"',
                             \'<html> proprietary attribute "prefix"',
                             \'trimming empty <span>',
                             \'trimming empty <i>',
                             \'<script> proprietary attribute "integrity"',
                             \'<link> proprietary attribute "integrity"',
                             \'<link> proprietary attribute "crossorigin"',
                             \'<script> proprietary attribute "crossorigin"'
                             \]
             endif
         endfunction
     augroup END
 endif

 " Set up CtrlP with faster alternative, if possible
 if executable('ag')
     " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
     set grepprg=ag\ --nogroup\ --nocolor
     " Use ag in CtrlP for listing files. Lightning fast, respects .gitignore
     " and .agignore. Ignores hidden files by default.
     let g:ctrlp_user_command = 'ag %s -l --nocolor -f -g ""'
     let g:ctrlp_use_caching = 0
 else
     if executable("rg")
         set grepprg=rg\ --color=never

         let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
         let g:ctrlp_use_caching = 0
     else
         "ctrl+p ignore files in .gitignore
         let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
     endif
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
     if(has("mouse"))
         set mouse=a
     endif
     if $TERM_PROGRAM == 'iTerm.app'
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
     if($ConEmuANSI == 'ON')
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
