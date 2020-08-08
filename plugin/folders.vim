" Stolen from maralla/dotvim
function! s:EnsureExists(path) abort
    let l:path = expand(a:path)
    if !isdirectory(l:path)
	try
            call mkdir(l:path)
        catch
            echom "Could not create directory " . l:path
	endtry
    endif
endfunction

call s:EnsureExists(resolve($MYVIM . '/.cache'))

" persistent undo
if exists('+undofile')
    let &undodir = resolve($MYVIM . '/.cache/undo')
    set undofile
    call s:EnsureExists(&undodir)
endif

" backups
let &backupdir=resolve($MYVIM . '/.cache/backup')
set backup
call s:EnsureExists(&backupdir)

" swap files
let &directory=resolve($MYVIM . '/.cache/swap')
set noswapfile
call s:EnsureExists(&directory)
