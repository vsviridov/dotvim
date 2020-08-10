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

nnoremap <buffer> <leader>D  :OmniSharpGotoDefinition<CR>
nnoremap <buffer> <leader>cc :OmniSharpGlobalCodeCheck<CR>
nnoremap <buffer> <F12>      :OmniSharpGetCodeActions<CR>
