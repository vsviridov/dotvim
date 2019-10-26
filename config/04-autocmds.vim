 if has('autocmd')
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

     " augroup CleanWhitespace
     "     au!
     "     autocmd BufWritePre * :call <SID>StripTrailingWhitespace()
     "     function! <SID>StripTrailingWhitespace()
     "         let l:pos = getpos('.')
     "         let l:_s=@/
     "         %s/\s\+$//e
     "         call setpos('.', l:pos)
     "         let @/=l:_s
     "     endfun
     " augroup END

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

         " let g:neoformat_javascript_prettier = {
         "             \ 'exe' : 'prettier',
         "             \ 'args': ['--stdin', '--trailing-comma=es5', '--single-quote'],
         "             \ 'stdin': 1
         "             \ }
     augroup END

     augroup typescript
         au!

         " call jspretmpl#register_tag('psql', 'pgsql')

         " autocmd FileType typescript JsPreTmpl pgsql

     augroup END

     augroup Dockerfile
         au!
         au BufNewFile,BufRead *.dockerfile   setf dockerfile
     augroup END

     augroup suffixes
         autocmd!

         let associations = [
            \["typescript", ".ts"],
            \["typescript", "/index.ts"],
            \["javascript", ".js"]
            \]

        for ft in associations
            execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
        endfor
     augroup END

     augroup Omnisharp
         au!
         autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

         autocmd FileType cs nnoremap <buffer> <leader>D :OmniSharpGotoDefinition<CR>
         autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
         autocmd FileType cs nnoremap <F12> :OmniSharpGetCodeActions<CR>

     augroup END
     
     augroup Signs
         autocmd BufEnter * sign define dummy
         autocmd BufEnter * execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
     augroup end
 endif
