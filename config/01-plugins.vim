let plug_path=expand(vim_files . '/autoload/plug.vim')
let have_plug=filereadable(plug_path)
if(!have_plug && executable('curl'))
    echo "Installing Plug"

    execute '!curl -fLo "' . plug_path . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . plug_path
    let have_plug = 1
endif

if(have_plug)
    call plug#begin(vim_files . '/plugged')

    Plug 'tpope/vim-sensible'             " Sensible defaults for vim
    Plug 'w0ng/vim-hybrid'                " Hybrid colorscheme
    Plug 'vim-airline/vim-airline'        " Status bar
    Plug 'vim-airline/vim-airline-themes' " Status bar themes
    Plug 'ivyl/vim-bling'                 " blink search results
    Plug 'ctrlpvim/ctrlp.vim'             " Fuzzy search
    Plug 'tacahiroy/ctrlp-funky'          " Fuzzy in-buffer search
    Plug 'tommcdo/vim-lion'               " Align stuff
    Plug 'tpope/vim-fugitive'             " Work with git repos
    Plug 'tpope/vim-surround'             " Surround with quotes
    Plug 'rking/ag.vim'                   " Silver Searcher Support
    Plug 'tpope/vim-commentary'           " Commenting
    " Plug 'vimwiki/vimwiki'                " http://vimwiki.github.io/

    " Language
    if executable('rails')
        Plug 'tpope/vim-rails'            " Rails integration
    endif
    Plug 'mattn/emmet-vim'                " ZenCoding
    Plug 'sheerun/vim-polyglot'           " Language Support Bundle

    Plug 'sbdchd/neoformat'               " Automatic code formatting

    Plug 'quramy/vim-js-pretty-template'  " Syntax highlight inside template strings
    Plug 'quramy/tsuquyomi'               " Language server support for TypeScript

    " Quality of life
    Plug 'edkolev/tmuxline.vim'

    if version >= 800
        Plug 'w0rp/ale'
    endif

    if stridx($SHELL, 'fish') >= 0
        Plug 'dag/vim-fish'               " Fish Shell Support
    endif

    call plug#end()

    if empty(glob(vim_files . '/plugged'))
        PlugInstall
    endif
endif


