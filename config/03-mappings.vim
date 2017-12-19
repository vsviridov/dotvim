"open config with \r
noremap <leader>r :edit $MYVIMRC<cr>
noremap <silent><leader>w :update<cr>
inoremap <silent><leader>w <Esc>:update<cr>a
cmap w!! w !sudo tee % >/dev/null

cmap eh e %:h/
cmap wh w %:h/

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

" let g:tsuquyomi_javascript_support = 1
" noremap <leader>p :echo tsuquyomi#hint()<cr>

noremap <leader>p :LspHover<cr>
noremap <leader>D :LspDefinition<cr>
noremap <leader>U :LspReferences<cr>

let g:ctrlp_funky_syntax_highlight = 1
nnoremap <leader>f :CtrlPFunky<CR>

