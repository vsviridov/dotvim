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

     augroup END

     augroup typescript
         au!
     augroup END

     augroup Dockerfile
         au!
         au BufNewFile,BufRead *.dockerfile   setf dockerfile
     augroup END

     augroup suffixes
         autocmd!

         let g:associations = [
            \['typescript', '.ts'],
            \['typescript', '/index.ts'],
            \['javascript', '.js']
            \]

        for g:ft in g:associations
            execute 'autocmd FileType ' . g:ft[0] . ' setlocal suffixesadd=' . g:ft[1]
        endfor

        unlet g:associations
        unlet g:ft
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
