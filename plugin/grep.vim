 " Set up CtrlP with faster alternative, if possible
if executable('ag')
    " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
    set grepprg=ag\ --nogroup\ --nocolor
    " Use ag in CtrlP for listing files. Lightning fast, respects .gitignore
    " and .agignore. Ignores hidden files by default.
    let g:ctrlp_user_command = 'ag %s -l --nocolor -f -g ""'
    let g:ctrlp_use_caching = 0
    finish
endif

if executable('rg')
    set grepprg=rg\ --color=never

    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
    finish
endif

"ctrl+p ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
