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
let g:python_host_prog='/usr/bin/python2.7'
let $VIMHOME = split(&rtp, ',')[0] " Find the Vim path

if has('vim_starting')
  " ensure that we always start with Vim defaults (as opposed to those set by the current system)
  " Save 'diff' as set all& resets it, from http://ruderich.org/simon/config/vimrc
  let s:save_diff = &diff
  set all&
  " this resets some values, eg 'history', so only do it once (that is why we check has('vim_starting'))
  set nocompatible                  " Don't be compatible with vi (ignored by neovim)
endif

if has('eval')
    let &diff = s:save_diff
    unlet s:save_diff
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding
" http://rbtnn.hateblo.jp/entry/2014/12/28/010913
set encoding=utf-8
scriptencoding utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug {{{
" https://github.com/junegunn/vim-plug/wiki/faq
if empty(glob("$VIMHOME/autoload/plug.vim"))
  silent !curl -fLo $VIMHOME/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

silent! call plug#begin("$VIMHOME/bundle")
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Markdown
Plug 'tpope/vim-markdown', { 'for': 'ghmarkdown' }
" Add-on to Tim Pope's markdown.vim to highlight using Github Flavored Markdown.
Plug 'jtratner/vim-flavored-markdown', { 'for': 'ghmarkdown' }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHP
" The official VIm indent script for PHP
Plug '2072/PHP-Indenting-for-VIm', { 'for': 'php' }
" Up-to-date PHP syntax file (5.3–5.6 support)
Plug 'StanAngeloff/php.vim', { 'for': 'php' }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git
" Shows git branch in statusline + tags to the one in .git/tags if exists
if executable('git')
  Plug 'tpope/vim-fugitive'
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Web
Plug 'mattn/emmet-vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
Plug 'ervandew/supertab'
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/matchit.zip'
Plug 'scrooloose/nerdcommenter'
Plug 'benekastah/neomake'
Plug 'tpope/vim-surround'
if v:version >= 704
  Plug 'haya14busa/incsearch.vim'
endif
" Highlights on f F t T
Plug 'bradford-smith94/quick-scope'
" Add visual marks in gutter
Plug 'kshenoy/vim-signature'
Plug 'godlygeek/tabular'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorschemes
Plug 'michalbachowski/vim-wombat256mod'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF, first repository contains plugin, the other commands and mappings
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Shows registers:
Plug 'junegunn/vim-peekaboo'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
" Examples of python interpolation:
" https://medium.com/brigade-engineering/sharpen-your-vim-with-snippets-767b693886db
" PHP/Symfony snippets: https://github.com/algotech/ultisnips-php
if v:version >= 704
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
endif
" Ansible
Plug 'pearofducks/ansible-vim'
" Detect tabs vs spaces
Plug 'tpope/vim-sleuth'
" Hashicorp plugins
Plug 'hashivim/vim-terraform'
" Syntax and more for tmux
Plug 'tmux-plugins/vim-tmux'
" TypeScript
Plug 'leafgarland/typescript-vim'
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader
" Needs to be set here, and not in bindings.vim as it is sourced to late
" http://www.reddit.com/r/vim/comments/1vdrxg/space_is_a_big_key_what_do_you_map_it_to/
let g:mapleader = "\<Space>"
map <Space> <Leader>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips
let g:snips_author = 'Henrik Farre <hfar@tv2.dk>'
let g:UltiSnipsEnableSnipMate = 0   " don't look for SnipMate snippets, in the 'snippets' dir

" Make it work in terminal, as shift-space does not work. Requires supertab http://stackoverflow.com/a/22253548
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" let g:UltiSnipsSnippetDir= expand("$HOME/.vim/UltiSnips" )

if !has("python3")
  let g:UltiSnipsNoPythonWarning = 1
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" incsearch {{{
" https://github.com/haya14busa/incsearch.vim
if has_key(g:plugs, 'incsearch')
  let g:incsearch#auto_nohlsearch = 0
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)
endif
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable plugins:
let g:loaded_html_danish = 1      " html_da
let g:loaded_netrwPlugin = 1      " netrw
let g:loaded_vimballPlugin = 1    " vimball
let loaded_matchparen = 1         " Parenthesis matching is just too slow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Emmet
let g:user_emmet_expandabbr_key = '<c-e>'
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
      \ 'html' : {
      \   'filters' : 'html',
      \   'indentation' : ' '
      \ },
      \ 'php' : {
      \   'extends' : 'html,javascript',
      \   'filters' : 'html,c',
      \ },
      \ 'css' : {
      \   'filters' : 'fc',
      \ }
      \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable syntax checking when in a diff
if &diff
  set noswapfile
  let g:loaded_javascript_syntax_checker = 1
  let g:loaded_html_syntax_checker = 1
  let g:loaded_xhtml_syntax_checker = 1
  let g:neomake_javascript_enabled_makers = []
  let g:neomake_html_enabled_makers = []
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
if has_key(g:plugs, 'fzf') && executable('fzf')
  nnoremap <leader>bv :Buffers<cr>
  " Dont use tmux split
  " https://github.com/junegunn/fzf.vim/issues/66#issuecomment-169362556
  " let g:fzf_layout = {}
  let g:fzf_nvim_statusline=1
  " Override env from shell where I prefer -e
  let $FZF_DEFAULT_OPTS = '-x --inline-info'

  " Find git root if it exists
  " https://github.com/junegunn/fzf.vim/issues/47#issuecomment-160237795
  function! s:fzf_root()
      let path = finddir(".git", expand("%:p:h").";")
      return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
  endfun

  nnoremap <silent> <Leader>t :exe 'Files ' . <SID>fzf_root()<CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabular
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>

" SuperTab
let g:SuperTabDefaultCompletionType = '<C-n>'

" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" vim-expand-region
" https://github.com/terryma/vim-expand-region
if has_key(g:plugs, 'vim-expand-region')
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)
endif

" NERD Commenter
map <F5> :call NERDComment(0, 'toggle')<CR>
inoremap <F5> <C-o>:call NERDComment(0, 'toggle')<C-m>
" Inset spaces, mostly for Drupal CS
let NERDSpaceDelims = 1

" JSON
" Don't hide "
let g:vim_json_syntax_conceal = 0

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ansible settings
" When this variable is set, indentation will completely reset (unindent to column 0) after two newlines in insert-mode. The normal behavior of YAML is to always keep the previous indentation, even across multiple newlines with no content.
let g:ansible_unindent_after_newline = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neomake
"
if has_key(g:plugs, 'neomake')
  " let g:neomake_verbose = 2
  " let g:neomake_logfile = '/tmp/neomake.log'
  " let g:neomake_php_phpmd_args = ['%:p', 'text', '/home/hfa/.config/phpmd/phpmd_swat_rules.xml']
  " Disable phpcs by default
  let g:neomake_php_enabled_makers = ['php', 'phpmd']
  let g:neomake_javascript_enabled_makers = ['jshint']
  let g:neomake_open_list=0
  let g:neomake_list_height=5
  " autocmd! BufWritePost * Neomake
  if has('nvim')
    call neomake#configure#automake('nrw', 750)
  else
    call neomake#configure#automake('w')
  endif
endif

" Terraform settings
let g:terraform_fmt_on_save=1       " Run terraform fmt on save to comply with style guide
let g:terraform_align=1             " Set indent to 2 spaces

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding
"
set fileencodings=utf-8,iso-8859-1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
"
set hlsearch                      " Highlight search results
set ignorecase                    " Do case insensitive matching, must be set for smartcase to work
set smartcase                     " Do smart case search - case sensitive if first letter in search is uppercase
set incsearch                     " Incremental search
set gdefault                      " Applies substitutions globally on lines, /g to disable

set infercase                     " Handle case in a smart way in autocompletes
set lazyredraw                    " Speed up macros

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding rules
"
" https://github.com/Konfekt/FastFold Refreshes on save
set foldmethod=indent             " fold based on indent
" set foldmethod=manual             " http://kevin.colyar.net/2011/05/fixing-vim-auto-complete-slowness-in-large-projects/
set foldnestmax=10                " deepest fold is 10 levels
set nofoldenable                  " dont fold by default
set foldlevel=1                   " this is just what i use
" set nofen                       " foldenable no
" set foldenable                  " enable folding
" set foldcolumn=2                " add a fold column
" set foldmethod=marker           " detect triple-{ style fold markers
" set foldlevelstart=0            " start out with everything folded
" set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo " which commands trigger auto-unfold

set number                        " Line numbers
" Switch between relativenumber and number on focus/enter/leave
" 703 corresponds to Vim 7.3
if v:version >= 703
  augroup vimrc_number
    autocmd!
    autocmd FocusLost * :set norelativenumber
    autocmd FocusGained * :set relativenumber
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
  augroup END
endif

set list
" set listchars=tab:▸\ ,eol:¬
set listchars=tab:\ \ ,extends:»,precedes:«,trail:▒,nbsp:·

"vertical/horizontal scroll off settings
set scrolloff=10                  " Keep lines between the cursor and bottom/top
set sidescrolloff=7
set sidescroll=1
" All abbrevitions, truncate middle of long messages, no intro when starting,
set shortmess=aTI
" no ins-completion-menu messages
if v:version > 704
  set shortmess+=c
endif

set nostartofline                 " Cursor does not jump to first nonblank char on line after buffer switch http://stackoverflow.com/questions/8292742/vim-cursor-jumps-to-begining-of-the-line-after-buffer-switch

"set showmatch                    " show matching brackets
"set mat=5                        " how many tenths of a second to blink matching brackets for

" More natural split opening
" http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session
"
set ssop-=options " do not store global and local values in a session
set ssop-=folds " do not store folds

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stuff
"
set backspace=indent,eol,start    " allow backspacing over everything in insert mode
if v:version > 704
  set breakindent                   " visually indent text: http://www.reddit.com/r/vim/comments/2jjtad/this_picture_says_it_all_thanks_to_uchrisbra10/
endif
set confirm                       " present a dialog
set display+=lastline             " A nicer way to show long wrapped lines
set title                         " change the terminals/windows title
set hid                           " change buffer without saving
set autowrite                     " Write contents of the file, if it has been modified, on buffer exit
set history=10000                 " remember more than the default 20 commands and search patterns
set virtualedit=block             " Allow the cursor to go in to 'invalid' places in visual block mode
set showcmd                       " Show (partial) command in status line.
set showmode                      " display the current mode
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
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
if v:version >= 704
  set formatoptions+=j
endif
" Indicates a fast terminal connection. More characters will be sent to the screen for redrawing
set ttyfast
" http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
set ttimeout
set ttimeoutlen=100
set timeoutlen=1000

" Do not autoread changed files, also see checktime augroup
set noautoread

set modeline                      " read settings for stuff like shiftwidth from current file
set modelines=3                   " number lines checked for modelines

if has("gui_running")
  set noesckeys                   " Get rid of the delay when hitting esc!, NOTE: this produces A,B,C,D in input mode using arrow
endif

set completeopt+=menu,longest,preview
set complete-=i                   " disabled scanning of include files
" set autochdir                     " always switch to the current file directory..
" not every vim is compiled with this, use the following line instead
" If you use command-t plugin, it conflicts with this, comment it out.
"autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

" Wrapping/linebreak
set textwidth=0                   " Do not wrap text
set linebreak                     " Do not softwrap the line in the middle of a word
set whichwrap=<,>,[,],h,l,b,s,~   " Make end/beginning-of-line cursor wrapping behave human-like, not vi-like

set wildmenu
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
" Store temporary files in a central spot
if !isdirectory($VIMHOME."/backups/")
    call mkdir($VIMHOME."/backups/", "", 0700)
endif

set backupdir=$VIMHOME/backups/
set backupskip=/tmp/*"            " Make Vim able to edit crontab files again.

if !isdirectory($VIMHOME."/swaps/")
    call mkdir($VIMHOME."/swaps/", "", 0700)
endif
set directory=$VIMHOME/swaps/       " swap files
" set viewdir=~/.vim/views/
" au BufWinLeave * silent! mkview         " make vim save view (state) (folds, cursor, etc)
" au BufWinEnter * silent! loadview       " make vim load view (state) (folds, cursor, etc)

" Use less space for line numbering if possible
if v:version >= 700
  try
      setlocal numberwidth=3
  catch
  endtry
endif

set keymodel=startsel             " Allow select of text in insert mode using shift

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlightning
"
syntax on                         " Enable syntax highlightning
filetype plugin on                " Enable filetype settings
filetype indent on
set synmaxcol=500                " Syntax coloring lines that are too long just slows down the world

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Diff
"
set diffopt+=iwhite               " Ignore whitespace
set diffexpr=""                   " When 'diffexpr' is empty, Vim uses this command to find the differences between file1 and file2: diff file1 file2 > outfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indention
" Note that modeline may override this
"
set softtabstop=2                 " Standard vi interprets the tab key literally, but there are popular vi-derived alternatives that are smarter, like vim. To get vim to interpret tab as an ``indent'' command instead of an insert-a-tab command
set shiftwidth=2                  " Number of spaces to use for each insertion of (auto)indent.
set shiftround                    " use multiple of shiftwidth when indenting with '<' and '>'
set tabstop=4                     " To cause the TAB file-character to be displayed as mod-N in vi and vim (what Emacs calls tab-width)
set expandtab                     " To cause TAB characters to not be used in the file for compression, and for only spaces to be used (what emacs calls indent-tabs-mode),
" set smarttab
set autoindent                    " keeps previous lines indent
" Disable smartindent
" http://stackoverflow.com/questions/18415492/autoindent-is-subset-of-smartindent-in-vim/18415867#18415867
" http://vim.wikia.com/wiki/Indenting_source_code#Methods_for_automatic_indentation
" set smartindent                   " insert tabs on the start of a line according to shiftwidth, not tabstop
set copyindent                    " copy the previous indentation on autoindenting
set preserveindent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" functions {{{
"
" http://ddrscott.github.io/blog/2016/vim-toggle-movement/
function! ToggleHomeZero()
  let pos = getpos('.')
  execute "normal! ^"
  if pos == getpos('.')
    execute "normal! 0"
  endif
endfunction

" FIXME: clashes with 0 g0 mapping in bindings
nnoremap 0 :call ToggleHomeZero()<CR>

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
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
command! TrimWhiteSpace call TrimWhiteSpace()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General keymaps
"
" Plugin mappings are in vimrc
" opens $MYVIMRC for editing, or use :tabedit $MYVIMRC
nmap <Leader>v :e $MYVIMRC<CR>
"
" http://vim.wikia.com/wiki/Toggle_auto-indenting_for_code_paste
" map <Leader>v :set invpaste<CR>:set paste?<CR>

" More natural cursor movement
map <silent> <up> gk
imap <silent> <up> <C-o>gk
map <silent> <down> gj
imap <silent> <down> <C-o>gj
map <silent> <home> g<home>
imap <silent> <home> <C-o>g<home>
map <silent> <end> g<end>
imap <silent> <end> <C-o>g<end>

" noremap <buffer> <silent> k gk
" noremap <buffer> <silent> j gj
" Fix moving pass wrapped lines: http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <buffer> <silent> 0 g0
noremap <buffer> <silent> $ g$
nnoremap H 0
nnoremap L $

" http://www.reddit.com/r/vim/comments/2ueu0g/which_pluginskeybindsetc_significantly_changed/
" expands %% to current file's directory in command-line mode
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

" From https://github.com/mkropat/vim-dwiw2015/blob/master/plugin/dwiw2015.vim#L212
" > -- shift selection rightwards (preserve selection) [Visual Mode]
vnoremap > >gv
" < -- shift selection leftwards (preserve selection) [Visual Mode]
vnoremap < <gv

" Easier split navigations
" http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>

nmap <BS> <C-h>

" Pipe char is \, use CTRL-V to find it
" '-' can't be used
" Works in guis:
" nnoremap <C-\|> <C-W>v
nnoremap <C-\> <C-W>v
nnoremap <C-_> :sp<CR>

" Disable search highlightning
nmap <silent> <C-N> :silent noh<CR>

" Invisible character
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Save keystrockes on save
" http://vim.wikia.com/wiki/Use_Ctrl-O_instead_of_Esc_in_insert_mode_mappings
imap <C-s> <C-o>:wa<CR>
nmap <C-s> :wa<CR>

" jk in insert mode is Escape
" imap jk <Esc>

" Map ' so it jumps to line and column
nnoremap ' `
nnoremap ` '

" Make shift-insert work like in Xterm
" map <S-Insert> <MiddleMouse>
" For command mode:
" map! <S-Insert> <MiddleMouse>

"  Useful mappings to paste and reformat/reindent
" nnoremap <leader>P P'[v']=
" nnoremap <leader>p p'[v']=

" yank till the end of the line
noremap Y "+y$

" Yank / Paste multiple lines easier
" Automatically jump to end of text you pasted
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vnoremap <silent> y y`]
" These leave `] when pasting using CTRL+o p
" vnoremap <silent> p p`]
" nnoremap <silent> p p`]
" :h gp
vnoremap <silent> p gp
nnoremap <silent> p gp

" Select pasted text, companion function to gv
noremap gV `[v`]

" Typos {{{
" http://blog.sanctum.geek.nz/vim-command-typos/
" http://vim.wikia.com/wiki/Handle_common_command_typos
cnoreabbrev q1 q!
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev Wq wq
cnoreabbrev Wqa wqa
cnoreabbrev WQa wqa
cnoreabbrev waq wqa
cnoreabbrev qwa wqa

cnoreabbrev n1 b1
cnoreabbrev n2 b2
cnoreabbrev n3 b3
cnoreabbrev n4 b4
cnoreabbrev n5 b5
cnoreabbrev n6 b6
cnoreabbrev n7 b7
cnoreabbrev n8 b8
cnoreabbrev n9 b9
cnoreabbrev B1 b1
cnoreabbrev B2 b2
cnoreabbrev B3 b3
cnoreabbrev B4 b4
cnoreabbrev B5 b5
cnoreabbrev B6 b6
cnoreabbrev B7 b7
cnoreabbrev B8 b8
cnoreabbrev B9 b9

if has("user_commands")
    command! -bang -nargs=? -complete=file E e<bang> <args>
    command! -bang -nargs=? -complete=file W w<bang> <args>
    command! -bang -nargs=? -complete=file Wq wq<bang> <args>
    command! -bang -nargs=? -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif
" }}}

" Disable Ex mode
map Q <Nop>
" Disable help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Disable increment of numbers, clashes with tmux
nmap <C-a> <Nop>

" Undo stuff
" nnoremap u <NOP>
" inoremap <C-u> <ESC>ui

" Open none existing file under cursor
nnoremap gF :view <cfile><cr>

" Bclose function ca be found in "Buffer related" section
map <leader>bd :Bclose<cr>
map <leader>b1 :b1<cr>
map <leader>b2 :b2<cr>
map <leader>b3 :b3<cr>
map <leader>b4 :b4<cr>
" Switch buffers using <leader>bn/bp, skips quickfix because autocmd has set
" it to nobuflisted
noremap <leader>bn :bn<cr>
noremap <leader>bp :bp<cr>

" Escape in terminal
" if has('nvim')
"   tnoremap <Esc> <C-\><C-n>
" endif

" Search for visually selected text:
" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>"<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbrevs
"
ab seperator separator
iab _DATE_ <C-r>=strftime("%Y-%m-%d")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto commands
"

" Omnicomplete
"
augroup vimrc_complete
  autocmd!
  " Use tern as completion
  " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType javascript setlocal omnifunc=tern#Complete
  autocmd FileType html,xhtml,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
augroup END

" Reads the skeleton files, delete empty line
if !&diff
  augroup vimrc_skeleton
    autocmd!
    autocmd BufNewFile *.module 0r $VIMHOME/skel/drupal_module |normal Gdd2h
    autocmd BufNewFile *.info 0r $VIMHOME/skel/drupal_info |normal Gdd2h
    autocmd BufNewFile *.html 0r $VIMHOME/skel/html | $,$d
    autocmd BufNewFile *.css 0r $VIMHOME/skel/css | $,$d
    autocmd BufNewFile *.sh 0r $VIMHOME/skel/bash | $,$d
    autocmd BufNewFile .tern-project 0r $VIMHOME/skel/tern-project | $,$d
    autocmd BufNewFile Dockerfile 0r $VIMHOME/skel/Dockerfile | $,$d
    autocmd BufNewFile .dockerignore 0r $VIMHOME/skel/dockerignore | $,$d
    autocmd BufNewFile hest.yml 0r $VIMHOME/skel/hest.yml | $,$d
  augroup END
endif

augroup vimrc_tmuxfiletype
  autocmd!
  autocmd BufNewFile,BufRead .tmux.conf setlocal filetype=tmux
augroup END

" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff <wouter@blub.net>
augroup encrypted
  autocmd!
  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre      *.gpg set viminfo=
  " We don't want a swap file, as it writes unencrypted data to disk
  autocmd BufReadPre,FileReadPre      *.gpg set noswapfile
  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre      *.gpg set bin
  autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
  autocmd BufReadPre,FileReadPre      *.gpg let shsave=&sh
  autocmd BufReadPre,FileReadPre      *.gpg let &sh='sh'
  autocmd BufReadPre,FileReadPre      *.gpg let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --decrypt --default-recipient-self 2> /dev/null
  autocmd BufReadPost,FileReadPost    *.gpg let &sh=shsave
  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost    *.gpg set nobin
  autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
  " Convert all text to encrypted text before writing
  autocmd BufWritePre,FileWritePre    *.gpg set bin
  autocmd BufWritePre,FileWritePre    *.gpg let shsave=&sh
  autocmd BufWritePre,FileWritePre    *.gpg let &sh='sh'
  autocmd BufWritePre,FileWritePre    *.gpg '[,']!gpg --encrypt --default-recipient-self 2>/dev/null
  autocmd BufWritePre,FileWritePre    *.gpg let &sh=shsave
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost  *.gpg   silent u
  autocmd BufWritePost,FileWritePost  *.gpg set nobin
augroup END

" Use github style markdown
augroup vimrc_markdown
    autocmd!
    " autocmd BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
    autocmd BufNewFile,BufRead *.md,*.markdown :call MarkdownTypeDetect()
augroup END

" Spelling, files for neovim: ftp://ftp.vim.org/pub/vim/runtime/spell/
augroup vimrc_spelling
    autocmd!
    autocmd FileType gitcommit,markdown,ghmarkdown,cucumber setlocal spell spelllang=en_us
    autocmd FileType gitcommit,markdown,ghmarkdown,cucumber setlocal complete+=kspell
augroup END

" Indent xml using xmllint
" - Only works for entire file
" augroup vimrc_xml
"     autocmd!
"     autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
" augroup END

" Use "json" to format .json
" https://github.com/trentm/json
augroup vimrc_json
    autocmd!
    autocmd FileType json setlocal equalprg=json
augroup END

" ansible-vim does not detect playbooks
augroup vimrc_ansible
    autocmd!
    autocmd BufRead,BufNewFile */ansible/*.yml set ft=yaml.ansible
    autocmd BufRead,BufNewFile inventory set ft=ansible_hosts
augroup END

" go-jira
augroup vimrc_gojira
  autocmd!
  autocmd BufRead,BufNewFile /tmp/comment*.yml setlocal spell spelllang=da
  autocmd BufRead,BufNewFile ~/.jira.d/templates/* setlocal ft=gotexttmpl
augroup END

" Jenkinsfile
augroup vimrc_jenkins
  autocmd!
  autocmd BufNewFile,BufRead Jenkinsfile setlocal filetype=groovy
  autocmd FileType grrovy setlocal omnifunc=javacomplete#Complete
augroup END

" Resize vdebug window
augroup vimrc_vdebug
  autocmd!
  autocmd WinEnter DebuggerWatch res 60
augroup END

augroup vimrc_whitespace
  autocmd!
  autocmd FileWritePre    *.{php,js,module,info,tpl,md} :call TrimWhiteSpace()
  autocmd FileAppendPre   *.{php,js,module,info,tpl,md} :call TrimWhiteSpace()
  autocmd FilterWritePre  *.{php,js,module,info,tpl,md} :call TrimWhiteSpace()
  autocmd BufWritePre     *.{php,js,module,info,tpl,md} :call TrimWhiteSpace()
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

" Hide quickfix from bufferlist
augroup vimrc_qfix
    autocmd!
    autocmd FileType qf setlocal nobuflisted
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
" Window titles
"
" Highlight VCS conflict markers
" Based on https://bitbucket.org/sjl/dotfiles/src/141b96496989091fce4aa5165946f94d31c2374f/vim/vimrc
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Tries to match statusline
if has('title')
  set titlestring=%{v:progname}:\ 
  " git branch
  if has_key(g:plugs, 'fugitive')
    set titlestring+=%{fugitive#statusline()}
  endif
  if has("gui_running")
    " Full path if gvim is used
    set titlestring+=\ %F\ 
  else
    " Display min 25, max 60 chars of F (Full path), from the right
    set titlestring+=\ %-25.60F\ 
  endif
  " r: Read only flag
  " y: Filetype
  " m: Modified flag
  set titlestring+=%m

  " display a warning if fileformat isnt unix
  set titlestring+=%{&ff!='unix'?'['.&ff.']':''}
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme
"
colorscheme wombat256mod

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cursor
"
hi Cursor cterm=reverse gui=reverse ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE
hi CursorLine term=underline cterm=underline guibg=#282828
hi CursorLineNr term=underline cterm=underline guifg=Grey guibg=#282828
set cursorline

" SignColumn
" hi SignColumn guibg=#121212 ctermbg=232
" Change split background between windows
hi VertSplit guibg=NONE guifg=#444444 ctermbg=NONE ctermfg=NONE

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Behavior
set selection=inclusive " Selection will include current char, set to exclusive else
set mousemodel=popup
set mouse=ar            " Mouse on, all modes + hit-enter/more-prompt

set cmdheight=1         " The commandbar is 1 high

if &diff
  " Fixes "press enter or type command to continue"
  set cmdheight=2
  " http://vim.wikia.com/wiki/Start_with_a_wide_window_for_diff
  let &columns = 320 + 2*&foldcolumn + 1
endif

function! AirlineGitInfo()
  let git = fugitive#head()
  if git != ''
    return ' '.git
  else
    return ''
  endif
endfunction

let g:airline_powerline_fonts = 1
let g:airline_theme = 'jellybeans'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
" Hides neomake output:
" let g:airline_skip_empty_sections = 1
let g:airline#extensions#neomake#enabled = 1
let g:airline#extensions#neomake#error_symbol = '✖ Error: '
let g:airline#extensions#neomake#warning_symbol = '⚠ Warning: '

let g:airline#extensions#whitespace#enabled = 0

let g:airline_section_b = '%{AirlineGitInfo()}'
let g:airline_section_c = '%<%-25.60F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
" l: Line number, c: column, V: virtual column, not displayed if == c
let g:airline_section_z = airline#section#create([ '%l,%c%V'])

set noshowmode
