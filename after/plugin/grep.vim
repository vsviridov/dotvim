" Remap ctrl+p to fzf
if exists('g:loaded_fzf')
    " nmap <C-P> :FZF<CR>
    " fzf file fuzzy search that respects .gitignore
    " If in git directory, show only files that are committed, staged, or unstaged
    " else use regular :Files
    nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
endif

