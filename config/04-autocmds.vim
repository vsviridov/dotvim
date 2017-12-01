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

         let g:neoformat_javascript_prettier = {
                     \ 'exe' : 'prettier',
                     \ 'args': ['--stdin', '--trailing-comma=es5', '--single-quote'],
                     \ 'stdin': 1
                     \ }
     augroup END

     augroup lsp
        au!
        if executable('typescript-language-server')
            au User lsp_setup call lsp#register_server({
                        \ 'name': 'typescript-language-server',
                        \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
                        \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
                        \ 'whitelist': ['typescript', 'javascript', 'javascript.jsx']
                        \ })
        endif

     augroup END
 endif
