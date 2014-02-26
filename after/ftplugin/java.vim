setlocal makeprg=ant\ -q\ -find\ build.xml
setlocal errorformat=\ %#[%.%#]\ %#%f:%l:%v:%*\\d:%*\\d:\ %t%[%^:]%#:%m,
    \%A\ %#[%.%#]\ %f:%l:\ %m,%-Z\ %#[%.%#]\ %p^,%C\ %#[%.%#]\ %#%m

", %-C%.%#
nmap <leader>m :make<cr><cr><cr>
setlocal colorcolumn=80

let g:syntastic_java_checkers=['checkstyle']
let g:syntastic_java_checkstyle_classpath='/usr/share/java/checkstyle.jar:/usr/share/java/commons-logging-1.1.1.jar'
let g:syntastic_java_checkstyle_conf_file='/usr/share/checkstyle/sun_checks.xml'

