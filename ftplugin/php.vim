""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlightning {{{
let php_sql_query = 1                     " If you like SQL syntax highlighting inside Strings
let php_htmlInStrings = 1                 " Enable HTML syntax highlighting inside strings
let php_parent_error_close = 1            " For highlighting parent error ] or )
let php_parent_error_open = 1             " For skipping a php end tag, if there exists an open ( or [ without a closing one
" let php_sync_method = 10
" let php_folding = 1                     " Enable folding for classes and functions
let g:PHP_removeCRwhenUnix = 1            " To automatically remove '\r' characters when the 'fileformat' is set to Unix:
let g:PHP_vintage_case_default_indent = 1 " To indent 'case:' and 'default:' statements in switch() blocks:
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHP complete {{{
" https://github.com/shawncplus/phpcomplete.vim/issues/48
" Conflicting mapping of C-]
let g:phpcomplete_enhance_jump_to_definition = 0
" When enabled the preview window's content will include information extracted
" from docblock comments of the completions. Enabling this option will add
" return types to the completion menu for functions too.
let g:phpcomplete_parse_docblock_comments = 1
" https://github.com/shawncplus/phpcomplete.vim/blob/master/misc/available_extensions
let g:phpcomplete_add_function_extensions = ["mysqli", "soap", "simplexml"]
let g:phpcomplete_add_class_extensions = ["mysqli", "soap", "pdo", "simplexml"]
let g:phpcomplete_search_tags_for_variables = 1
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabularize {{{
if has_key(g:plugs, 'tabular')
  vnoremap <buffer> <F3> :Tabularize /=><CR>
endif
" }}}

" Map ; to add ; to the end of the line, when missing
noremap <buffer> ; :norm A;<CR>
