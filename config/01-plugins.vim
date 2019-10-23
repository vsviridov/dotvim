set encoding=utf-8
scriptencoding utf-8

let g:plug_path=expand(g:vim_files . '/autoload/plug.vim')
let g:have_plug=filereadable(g:plug_path)
if(!g:have_plug && executable('curl'))
    echo 'Installing Plug'

    execute '!curl -fLo "' . g:plug_path . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . g:plug_path
    let g:have_plug = 1
endif

if(g:have_plug)
    call plug#begin(g:vim_files . '/plugged')

    Plug 'tpope/vim-sensible'             " Sensible defaults for vim

    Plug 'ctrlpvim/ctrlp.vim'             " Fuzzy search
    Plug 'editorconfig/editorconfig-vim'  " EditorConfig.org support
    Plug 'ivyl/vim-bling'                 " blink search results
    if executable('ag')
        Plug 'rking/ag.vim'               " Silver Searcher Support
    endif
    if executable('rg')
        Plug 'jremmen/vim-ripgrep'        " RipGrep
    endif
    Plug 'tacahiroy/ctrlp-funky'          " Fuzzy in-buffer search
    Plug 'tommcdo/vim-lion'               " Align stuff
    Plug 'tpope/vim-abolish'              " Case Convert and other stuff
    Plug 'tpope/vim-commentary'           " Commenting
    Plug 'tpope/vim-fugitive'             " Work with git repos
    Plug 'tpope/vim-surround'             " Surround with quotes
    Plug 'vim-airline/vim-airline'        " Status bar
    Plug 'vim-airline/vim-airline-themes' " Status bar themes
    " Plug 'vimwiki/vimwiki'                " http://vimwiki.github.io/
    Plug 'w0ng/vim-hybrid'                " Hybrid colorscheme
    Plug 'christoomey/vim-sort-motion'    " Sort Motions

    " Language
    if executable('rails')
        Plug 'tpope/vim-rails'            " Rails integration
    endif
    Plug 'mattn/emmet-vim'                " ZenCoding
    Plug 'sheerun/vim-polyglot'           " Language Support Bundle
    Plug 'ianks/vim-tsx'


    " Plug 'quramy/vim-js-pretty-template'  " Syntax highlight inside template strings
    " Plug 'quramy/tsuquyomi'             " Language server support for TypeScript

    " Plug 'heavenshell/vim-jsdoc'        " Generate JSDoc comments

    " Quality of life
    " Plug 'edkolev/tmuxline.vim'
    Plug 'jez/vim-superman'               " Man page viewer
    Plug 'mhinz/vim-signify'              " Gutter signs, git, et al.

    " Plug 'sotte/presenting.vim'           " Slides

    if v:version >= 800
        Plug 'w0rp/ale'                   " Asynchronous Linting
        Plug 'sbdchd/neoformat'           " Automatic code formatting

        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'OmniSharp/omnisharp-vim'

        Plug 'ruanyl/coverage.vim'        " Code Coverage Support
    endif

    if stridx($SHELL, 'fish') >= 0
        Plug 'dag/vim-fish'               " Fish Shell Support
    endif

    call plug#end()

    if empty(glob(g:vim_files . '/plugged'))
        PlugInstall
    endif
endif

let g:loaded_netrwPlugin = 1              " Disable netrw

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_sign_column_always = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_fix_on_save = 1
" let g:ale_completion_enabled = 1

let g:ale_linters = {
            \   'typescript': ['tsserver'],
            \   'typescript.tsx': ['tsserver'],
            \   'cs': ['OmniSharp']
            \}

let g:coverage_json_report_path = 'coverage/coverage-final.json'
let g:coverage_sign_covered = ''
let g:coverage_sign_uncovered = ''

let g:signify_vcs_list = [ 'git' ]

let g:LanguageClient_waitOutputTimeout = 1
let g:LanguageClient_serverCommands = {
      \ 'typescript': ['javascript-typescript-stdio'],
      \ 'typescript.tsx': ['javascript-typescript-stdio'],
      \ }

let g:deoplete#enable_at_startup = 1

let g:neoformat_nginx_nginxbeautifier = {
    \ 'exe': 'nginxbeautifier',
    \ 'replace': 1,
    \ }

let g:neoformat_enabled_nginx = ['nginxbeautifier']

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_selector_ui = 'ctrlp'
let g:OmniSharp_highlight_groups = {
            \ 'csUserIdentifier': [
            \   'constant name', 'enum member name', 'field name', 'identifier',
            \   'local name', 'parameter name', 'property name', 'static symbol'],
            \ 'csUserInterface': ['interface name'],
            \ 'csUserMethod': ['extension method name', 'method name'],
            \ 'csUserType': ['class name', 'enum name', 'namespace name', 'struct name']
            \}
let g:OmniSharp_highlight_types = 2

sign define OmniSharpCodeActions text=💡
augroup OSCountCodeActions
    autocmd!
    autocmd FileType cs set signcolumn=yes
    autocmd CursorHold *.cs call OSCountCodeActions()
augroup END

function! OSCountCodeActions() abort
    if bufname('%') ==# '' || OmniSharp#FugitiveCheck() | return | endif
    if !OmniSharp#IsServerRunning() | return | endif
    let opts = {
                \ 'CallbackCount': function('s:CBReturnCount'),
                \ 'CallbackCleanup': {-> execute('sign unplace 99')}
                \}
    call OmniSharp#CountCodeActions(opts)
endfunction

function! s:CBReturnCount(count) abort
    if a:count
        let l = getpos('.')[1]
        let f = expand('%:p')
        execute ':sign place 99 line='.l.' name=OmniSharpCodeActions file='.f
    endif
endfunction
