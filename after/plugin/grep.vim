" Remap ctrl+p to fzf
if exists('g:loaded_fzf')
    " nmap <C-P> :FZF<CR>
    " fzf file fuzzy search that respects .gitignore
    " If in git directory, show only files that are committed, staged, or unstaged
    " else use regular :Files
    nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"

    command! -bang -nargs=* Find
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always '.shellescape(expand('<cword>')), 1,
                \   <bang>0 ? fzf#vim#with_preview('up:60%')
                \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                \   <bang>0)
endif

