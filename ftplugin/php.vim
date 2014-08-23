" Syntax highlightning
let php_sql_query = 1 " If you like SQL syntax highlighting inside Strings
let php_htmlInStrings = 1 "Enable HTML syntax highlighting inside strings
let php_parent_error_close = 1 "For highlighting parent error ] or )
let php_parent_error_open = 1 "For skipping a php end tag, if there exists an open ( or [ without a closing one
" let php_sync_method = 10
" let php_folding = 1 "Enable folding for classes and functions
let g:PHP_removeCRwhenUnix = 1 " To automatically remove '\r' characters when the 'fileformat' is set to Unix:
let g:PHP_vintage_case_default_indent = 1 " To indent 'case:' and 'default:' statements in switch() blocks:

if has("gui_running")
  set keywordprg=~/.vim/scripts/php_lookup.sh\ gui
else
  set keywordprg=~/.vim/scripts/php_lookup.sh
endif

vnoremap <F3> :call PhpAlign()<CR>
noremap ; :s/\([^;]\)$/\1;/<cr>:nohls<cr> " Map ; to add ; to the end of the line, when missing

func! PhpAlign() range
    let l:paste = &g:paste
    let &g:paste = 0

    let l:line        = a:firstline
    let l:endline     = a:lastline
    let l:maxlength = 0
    while l:line <= l:endline
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
        let l:index = substitute (getline (l:line), '^\s*\(.\{-\}\)\s*=>\{0,1\}.*$', '\1', "") 
        let l:indexlength = strlen (l:index)
        let l:maxlength = l:indexlength > l:maxlength ? l:indexlength : l:maxlength
        let l:line = l:line + 1
    endwhile
    
	let l:line = a:firstline
	let l:format = "%s%-" . l:maxlength . "s %s %s"
    
	while l:line <= l:endline
		if getline (l:line) =~ '^\s*\/\/.*$'
			let l:line = l:line + 1
			continue
		endif
        let l:linestart = substitute (getline (l:line), '^\(\s*\).*', '\1', "")
        let l:linekey   = substitute (getline (l:line), '^\s*\(.\{-\}\) *=>\{0,1\}.*$', '\1', "")
        let l:linesep   = substitute (getline (l:line), '^\s*.* *\(=>\{0,1\}\).*$', '\1', "")
        let l:linevalue = substitute (getline (l:line), '^\s*.* *=>\{0,1\}\s*\(.*\)$', '\1', "")

        let l:newline = printf (l:format, l:linestart, l:linekey, l:linesep, l:linevalue)
        call setline (l:line, l:newline)
        let l:line = l:line + 1
    endwhile
    let &g:paste = l:paste
endfunc
