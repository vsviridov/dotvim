setlocal makeprg=ant\ -q\ -find\ build.xml
setlocal errorformat=\ %#[%.%#]\ %#%f:%l:%v:%*\\d:%*\\d:\ %t%[%^:]%#:%m,
    \%A\ %#[%.%#]\ %f:%l:\ %m,%-Z\ %#[%.%#]\ %p^,%C\ %#[%.%#]\ %#%m

", %-C%.%#
nmap <leader>m :make<cr><cr>
setlocal colorcolumn=80
