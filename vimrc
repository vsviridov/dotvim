set encoding=utf-8
scriptencoding utf-8

let g:vim_files=fnamemodify(resolve(expand('$MYVIMRC')), ':p:h')

function! SourceConfig(name)
    " exec "echo 'Loading " . a:name . "'"
    exec 'source ' . expand(g:vim_files . '/config/' . a:name)
endfunction

call SourceConfig('01-plugins.vim')
call SourceConfig('02-general.vim')
call SourceConfig('03-mappings.vim')
call SourceConfig('04-autocmds.vim')

unlet g:vim_files
