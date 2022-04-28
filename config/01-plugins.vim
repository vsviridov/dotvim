set encoding=utf-8
scriptencoding utf-8

let s:plug_path=expand($MYVIM . '/autoload/plug.vim')
let s:have_plug=filereadable(s:plug_path)
if(!s:have_plug && executable('curl'))
    echo 'Installing Plug'

    execute '!curl -fLo "' . s:plug_path . '" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    execute 'source ' . s:plug_path
    let s:have_plug = 1
endif

if(s:have_plug)
    let s:plugged=resolve($MYVIM . '/.cache/plugged')
    call plug#begin(s:plugged)

    Plug 'tpope/vim-sensible'             " Sensible defaults for vim

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

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
    " Plug 'OrangeT/vim-csharp'             " C# Support

    Plug 'mhinz/vim-signify'              " Gutter signs, git, et al.
    " Plug 'sotte/presenting.vim'           " Slides

    if v:version >= 800
        Plug 'dense-analysis/ale'         " Asynchronous Linting
        Plug 'sbdchd/neoformat'           " Automatic code formatting
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'Shougo/deoplete.nvim'       " Autocomplete Support
        Plug 'ruanyl/coverage.vim'        " Code Coverage Support
        if executable('ctags')
            Plug 'liuchengxu/vista.vim'   " LSP Tagbar
        endif
        Plug 'OmniSharp/omnisharp-vim'    " .Net completion
        Plug 'nickspoons/vim-sharpenup'   " OmniSharp Helpers
    endif

    if stridx($SHELL, 'fish') >= 0
        Plug 'dag/vim-fish'               " Fish Shell Support
    endif

    call plug#end()

    if empty(glob(s:plugged))
        PlugInstall --sync
    endif
endif

let g:loaded_netrwPlugin = 1              " Disable netrw

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_sign_column_always = 1
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_linters_explicit = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_use_global = 1
let g:ale_disable_lsp = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

let g:coverage_json_report_path = 'coverage/coverage-final.json'
let g:coverage_sign_covered = ''
let g:coverage_sign_uncovered = ''

let g:signify_vcs_list = [ 'git' ]

let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_nginx = ['nginxbeautifier']

" let g:coc_node_path = '/usr/bin/node'
