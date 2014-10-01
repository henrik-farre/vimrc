" Syntax highlightning
let php_sql_query = 1                     " If you like SQL syntax highlighting inside Strings
let php_htmlInStrings = 1                 " Enable HTML syntax highlighting inside strings
let php_parent_error_close = 1            " For highlighting parent error ] or )
let php_parent_error_open = 1             " For skipping a php end tag, if there exists an open ( or [ without a closing one
" let php_sync_method = 10
" let php_folding = 1                     " Enable folding for classes and functions
let g:PHP_removeCRwhenUnix = 1            " To automatically remove '\r' characters when the 'fileformat' is set to Unix:
let g:PHP_vintage_case_default_indent = 1 " To indent 'case:' and 'default:' statements in switch() blocks:

if has("gui_running")
  set keywordprg=~/.vim/scripts/php_lookup.sh\ gui
else
  set keywordprg=~/.vim/scripts/php_lookup.sh
endif

" Tabularize {
if exists(":Tabularize")
  vnoremap <F3> :Tabularize /=><CR>
endif
" }

" Map ; to add ; to the end of the line, when missing
noremap ; :norm A;<CR>
