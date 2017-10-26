"open config with \r
nmap <leader>r :e $MYVIMRC<cr>
nmap <silent><leader>w :up<cr>
imap <silent><leader>w <Esc>:up<cr>a
cmap w!! w !sudo tee % >/dev/null

"Remove search highlight when <Esc> is pressed
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

"toggle whitespace
nmap <leader>l :set list!<cr>

" noremap <silent> <leader>R :! echo reload \| nc -w 1 localhost 32000<cr><cr>
noremap <silent><leader>R :! tmux send-keys -t right "up" C-m<cr><cr>

"press space in normal mode to center screen
nmap <space> zz
nmap <leader>] :bn<cr>
nmap <leader>[ :bp<cr>
nmap <leader>d :bd<cr>

if(exists("g:loaded_ale"))
    nmap <leader>e[ <Plug>(ale_previous_wrap)
    nmap <leader>e] <Plug>(ale_next_wrap)
endif

let g:tsuquyomi_javascript_support = 1
if(exists("g:loaded_tsuquyomi"))
    nmap <leader>p :echo tsuquyomi#hint()<cr>
endif

let g:ctrlp_funky_syntax_highlight = 1
if(exists("g:loaded_ctrlp_funky"))
    nnoremap <leader>f :CtrlPFunky<CR>
endif

