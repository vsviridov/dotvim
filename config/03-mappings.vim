"open config with \r
noremap <leader>r :edit $MYVIMRC<cr>
noremap <silent><leader>w :update<cr>
inoremap <silent><leader>w <Esc>:update<cr>a
cmap w!! w !sudo tee % >/dev/null

" cmap eh e %:h/
" cmap wh w %:h/
" cmap %% %:h<tab>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h') . '/' : '%%'
cnoremap <expr> %b getcmdtype() == ':' ? expand('%:p:r') : '%b'

"Remove search highlight when <Esc> is pressed
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

"toggle whitespace
noremap <leader>l :set list!<cr>

" noremap <silent> <leader>R :! echo reload \| nc -w 1 localhost 32000<cr><cr>
noremap <silent><leader>R :! tmux send-keys -t top-right "up" C-m<cr><cr>

"press space in normal mode to center screen
noremap <space> zz
noremap <leader>] :bn<cr>
noremap <leader>[ :bp<cr>
noremap <leader>d :bd<cr>

" if exists('g:loaded_ale')
    " nmap <leader>e[ <Plug>(ale_previous_wrap)
    " nmap <leader>e] <Plug>(ale_next_wrap)

    " nmap <leader>p <Plug>(ale_hover)
    " nmap <leader>D <Plug>(ale_go_to_definition)
    " nmap <leader>U <Plug>(ale_find_references)
" endif

" if exists('g:loaded_ctrlp_funky')
    " let g:ctrlp_funky_syntax_highlight = 1
    " nnoremap <leader>f :CtrlPFunky<CR>
" endif

" if exists('g:LanguageClient_loaded')
    " nnoremap <F5> :call LanguageClient_contextMenu()<CR>
    " nnoremap <F12> :call LanguageClient_textDocument_codeAction()<CR>
" endif

" coc.nvim
function! s:check_back_space() abort
    let l:col = col('.') - 1
    return !l:col || getline('.')[l:col - 1] =~? '\s'
endfunction

function! s:show_documentation()
    if &filetype ==# 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

nmap <silent> <leader>T <Plug>(coc-type-definition)
nmap <silent> <leader>D <Plug>(coc-definition)
nmap <silent> <leader>U <Plug>(coc-references)
nmap <silent> <leader>I <Plug>(coc-implemenetation)
nnoremap <silent> <leader>p :call <SID>show_documentation()<CR>
nmap <silent> <leader>e[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>e] <Plug>(coc-diagnostic-next)
nnoremap <F12> :<C-u>CocList commands<cr>
