" vim:fdm=marker
"
" Explanation of vimrc
" https://gist.github.com/romainl/9ecd7b09a693816997ba
"
" Anti-pattern of vimrc
" http://rbtnn.hateblo.jp/entry/2014/12/28/010913
"
" http://usevim.com/2014/03/28/vimrc-folding/
" from http://www.reddit.com/r/vim/comments/20eyjk/preventing_plugin_clash_and_key_lag_sculpting/
"
" Variable scope: http://www.ibm.com/developerworks/library/l-vim-script-1/#N101F8
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stuff
"
set confirm                       " present a dialog
set display+=lastline             " A nicer way to show long wrapped lines
set hid                           " change buffer without saving
set virtualedit=block             " Allow the cursor to go in to 'invalid' places in visual block mode
set showmode                      " display the current mode
set showfulltag                   " Show full tag for completion
set switchbuf=useopen             " Buffer switching the reuses already visible buffers
" http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
" html.vim overrides comments setting, so a fix is in vimrc_php autocmd group
"  -t:  Do not apply 'textwidth' to code.
"  +c:  Apply 'textwidth' to comments.
"  +r:  Continue comments after hitting <Enter> in Insert mode.
"  +o:  Continue comments after when using 'O' or 'o' to open a new line.
"  +q:  Format comments using q<motion>.
"  +l:  Do not break a comment line if it is long before you start.
"  +j:  Where it makes sense, remove a comment leader when joining lines.
set formatoptions-=t
set formatoptions+=croql
" Fix comments when jusing j to join lines
set formatoptions+=j
" http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
" set ttimeout
" set timeoutlen=1000
" " NeoVim handles ESC keys as alt+key set this to solve the problem
" " https://github.com/neovim/neovim/issues/2051
" set ttimeoutlen=0

" Set updatetime to make floating windows appear faster
set updatetime=250

" Avoid adding newline to last line of file
set binary noeol

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clipboard
"
" In insert mode:
" - <C+r> *: Primary selection
" - <C+r> +: Contents of clipboard
set clipboard+=unnamedplus

if exists('$WAYLAND_DISPLAY') && has("wsl")
  " https://github.com/neovim/neovim/issues/10223
  " clipboard on wayland with newline fix
  let g:clipboard = {
    \   'name': 'WL-Clipboard with ^M Trim',
    \   'copy': {
    \      '+': 'wl-copy --foreground --type text/plain',
    \      '*': 'wl-copy --foreground --type text/plain --primary',
    \    },
    \   'paste': {
    \      '+': {-> systemlist('wl-paste --no-newline --type "text/plain;charset=utf-8" 2>/dev/null | sed -e "s/\r$//"', '', 1)},
    \      '*': {-> systemlist('wl-paste --no-newline --type "text/plain;charset=utf-8" --primary 2>/dev/null | sed -e "s/\r$//"', '', 1)},
    \   },
    \   'cache_enabled': 1,
    \ }
endif

set modeline                      " read settings for stuff like shiftwidth from current file
set modelines=3                   " number lines checked for modelines

" set completeopt+=menu,longest,preview
set completeopt=menu,menuone,noselect
set complete-=i                   " disabled scanning of include files

" spelling
set spellsuggest=best,9
set spell
set spelllang=en
set spelloptions+=noplainbuffer,camel

" Based on https://bitbucket.org/sjl/dotfiles/src/141b96496989091fce4aa5165946f94d31c2374f/vim/vimrc
set wildignore+=.hg,.git,.svn,CSV                " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.orig                           " Merge resolution files

set wildmode=list:longest,full
if exists("&wildignorecase")
  set wildignorecase
endif
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,CVS/,tags

set nobackup                      " dont use backups
" set noswapfile                  " do not write annoying intermediate swap files, who did ever restore from swap files anyway?
set backupskip=/tmp/*"            " Make Vim able to edit crontab files again.

set keymodel=startsel             " Allow select of text in insert mode using shift

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
"
" http://ddrscott.github.io/blog/2016/vim-toggle-movement/
function! ToggleHomeZero()
  let pos = getpos('.')
  execute "normal! ^"
  if pos == getpos('.')
    execute "normal! 0"
  endif
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

" Sudo write (from http://git.tpope.net/tpope.git?a=blob&f=.vimrc )
" remember to use sudo -e instead
command! -bar -nargs=0 SudoW   :silent exe "write !sudo tee % >/dev/null"|silent edit!

" <SID> explanation: http://stackoverflow.com/questions/16768059/how-to-understand-these-vim-scripts
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif

  if bufnr("%") == l:currentBufNum
    new
  endif

  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction

" Removes trailing spaces
function! TrimWhiteSpace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s///e
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
command! TrimWhiteSpace call TrimWhiteSpace()

" Replaces escaped chars like \n and \t with the real ones
function! ReplaceEscapedChars()
  %s/\\n/\r/
  %s/\\t/\t/
endfunction
command! ReplaceEscapedChars call ReplaceEscapedChars()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbrevs
"
iabbrev seperator separator
iabbrev lenght length
iab _DATE_ <C-r>=strftime("%Y-%m-%d")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands
"

" Use github style markdown
augroup vimrc_markdown
    autocmd!
    autocmd BufNewFile,BufRead *.md,*.markdown :call MarkdownTypeDetect()
augroup END

" Make sure Vim returns to the same line when you reopen a file.
" Based on
" https://bitbucket.org/sjl/dotfiles/src/141b96496989091fce4aa5165946f94d31c2374f/vim/vimrc
augroup vimrc_line_return
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Detect Markdown filetype
"
function! MarkdownTypeDetect()
  setlocal filetype=ghmarkdown
  if expand("%:p:h") =~ 'content'
    setlocal filetype=ghmarkdown.hugo
  endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable syntax highlighting in big files
" https://www.reddit.com/r/neovim/comments/s232p5/when_i_open_mega_filesover_gb_neovim_usually/
"
function DisableSyntaxTreesitter()
    echo("Big file, disabling syntax, treesitter and folding")
    if exists(':TSBufDisable')
        exec 'TSBufDisable autotag'
        exec 'TSBufDisable highlight'
        " etc...
    endif

    set foldmethod=manual
    syntax clear
    syntax off
    filetype off
    set noundofile
    set noswapfile
    set noloadplugins
endfunction

augroup BigFileDisable
    autocmd!
    autocmd BufReadPost * if getfsize(expand("%")) > 512 * 1024 | exec DisableSyntaxTreesitter() | endif
augroup END