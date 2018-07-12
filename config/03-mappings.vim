"open config with \r
noremap <leader>r :edit $MYVIMRC<cr>
noremap <silent><leader>w :update<cr>
inoremap <silent><leader>w <Esc>:update<cr>a
cmap w!! w !sudo tee % >/dev/null

" cmap eh e %:h/
" cmap wh w %:h/

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

nmap <leader>e[ <Plug>(ale_previous_wrap)
nmap <leader>e] <Plug>(ale_next_wrap)

nmap <leader>p <Plug>(ale_hover)
nmap <leader>D <Plug>(ale_go_to_definition)
nmap <leader>U <Plug>(ale_find_references)

let g:ctrlp_funky_syntax_highlight = 1
nnoremap <leader>f :CtrlPFunky<CR>

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <F12> :call LanguageClient_textDocument_codeAction()<CR>
