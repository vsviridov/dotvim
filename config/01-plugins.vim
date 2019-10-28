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
    if executable('ag')
        Plug 'rking/ag.vim'               " Silver Searcher Support
    endif
    if executable('rg')
        Plug 'jremmen/vim-ripgrep'        " RipGrep
    endif
    Plug 'tommcdo/vim-lion'               " Align stuff
    Plug 'tpope/vim-abolish'              " Case Convert and other stuff
    Plug 'tpope/vim-commentary'           " Commenting
    Plug 'tpope/vim-fugitive'             " Work with git repos
    Plug 'tpope/vim-surround'             " Surround with quotes
    Plug 'vim-airline/vim-airline'        " Status bar
    Plug 'vim-airline/vim-airline-themes' " Status bar themes
    Plug 'w0ng/vim-hybrid'                " Hybrid colorscheme
    Plug 'christoomey/vim-sort-motion'    " Sort Motions

    " Language
    Plug 'mattn/emmet-vim'                " ZenCoding
    Plug 'sheerun/vim-polyglot'           " Language Support Bundle
    Plug 'ianks/vim-tsx'
    Plug 'OrangeT/vim-csharp'             " C# Support


    " Plug 'mhinz/vim-signify'              " Gutter signs, git, et al.
    " Plug 'sotte/presenting.vim'           " Slides

    if v:version >= 800
        Plug 'w0rp/ale'                   " Asynchronous Linting
        Plug 'sbdchd/neoformat'           " Automatic code formatting
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'Shougo/deoplete.nvim'       " Autocomplete Support
        Plug 'ruanyl/coverage.vim'        " Code Coverage Support
        Plug 'liuchengxu/vista.vim'       " LSP Tagbar
        Plug 'OmniSharp/omnisharp-vim'    " .Net completion
    endif

    if stridx($SHELL, 'fish') >= 0
        Plug 'dag/vim-fish'               " Fish Shell Support
    endif

    call plug#end()

    if empty(glob(g:vim_files . '/plugged'))
        PlugInstall --sync
    endif
endif

let g:loaded_netrwPlugin = 1              " Disable netrw

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

let g:ale_sign_column_always = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_fix_on_save = 1

let g:ale_linters = {
            \   'typescript': ['tsserver'],
            \   'typescript.tsx': ['tsserver'],
            \   'cs': ['OmniSharp']
            \}

let g:coverage_json_report_path = 'coverage/coverage-final.json'
let g:coverage_sign_covered = ''
let g:coverage_sign_uncovered = ''

let g:signify_vcs_list = [ 'git' ]

let g:neoformat_html_prettier = {
            \ 'exe': 'prettier',
            \ 'typescript': ['typescript-language-server', '--stdio'],
            \ 'javascript': ['javascript-typescript-stdio'],
            \ 'javascript.jsx': ['javascript-typescript-stdio'],
            \ }

let g:neoformat_enabled_html = ['prettier']

let g:neoformat_nginx_nginxbeautifier = {
            \ 'exe': 'nginxbeautifier',
            \ 'replace': 1,
            \ }

let g:neoformat_enabled_nginx = ['nginxbeautifier']

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_selector_ui = 'ctrlp'
let g:OmniSharp_highlight_groups = {
            \ 'csUserIdentifier': [
            \ 'constant name', 'enum member name', 'field name', 'identifier',
            \ 'local name', 'parameter name', 'property name', 'static symbol'],
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
    let l:opts = {
            \ 'CallbackCount': function('s:CBReturnCount'),
            \ 'CallbackCleanup': {-> execute('sign unplace 99')}
            \}
    call OmniSharp#CountCodeActions(l:opts)
endfunction

function! s:CBReturnCount(count) abort
    if a:count
        let l:l = getpos('.')[1]
        let l:f = expand('%:p')
        execute ':sign place 99 line='.l:l.' name=OmniSharpCodeActions file='.l:f
    endif
endfunction
