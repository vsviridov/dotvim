if has('gui_running')
    set guioptions-=mTr " disable toolbar, menubar and scrollbar
    if has('win32')
        set guifont=Source_Code_Pro:h12:cANSI
    endif
    if has('osx')
        set guifont=Source_Code_Pro:h13
    endif
else
    if(has('mouse'))
        set mouse=a
    endif
endif
