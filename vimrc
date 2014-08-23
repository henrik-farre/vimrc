" vim:fdm=marker
" http://usevim.com/2014/03/28/vimrc-folding/
" from http://www.reddit.com/r/vim/comments/20eyjk/preventing_plugin_clash_and_key_lag_sculpting/
if has('vim_starting')
  " ensure that we always start with Vim defaults (as opposed to those set by the current system)
  set all&
  " this resets some values, eg 'history', so only do it once (that is why we check has('vim_starting'))
  set nocompatible                  " Don't be compatible with vi
endif

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " pathogen {{{
" "
" let g:pathogen_disabled = []
" 
" " vim on arch is compiled with -python3, and the console version also does not
" " have python
" if !has("python") 
"   call add(g:pathogen_disabled, 'tern_for_vim')
"   call add(g:pathogen_disabled, 'ultisnips')
" endif
" 
" filetype off
" runtime! autoload/pathogen.vim
" silent! call pathogen#helptags()
" silent! call pathogen#runtime_append_all_bundles()
" 
" " }}}

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'Raimondi/delimitMate'
Plugin 'vim-scripts/matchit.zip'
Plugin 'tpope/vim-haml'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'mileszs/ack.vim'
Plugin 'othree/html5.vim'
Plugin 'beyondwords/vim-twig'
Plugin 'majutsushi/tagbar'
Plugin 'kien/ctrlp.vim'
Plugin 'sickill/vim-pasta'
Plugin 'SirVer/ultisnips'
Plugin 'kshenoy/vim-signature'
Plugin 'nono/vim-handlebars'
Plugin 'godlygeek/tabular'
Plugin 'chrisbra/Recover.vim'
Plugin 'tpope/vim-repeat'
Plugin 'joonty/vdebug'
Plugin 'marijnh/tern_for_vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/emmet-vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'groenewege/vim-less'
Plugin 'mtth/scratch.vim'
Plugin 'tpope/vim-fugitive'
Plugin '2072/PHP-Indenting-for-VIm'
Plugin 'honza/vim-snippets'
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'sgur/ctrlp-extensions.vim.git'
Plugin 'pangloss/vim-javascript.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let mapleader = "," 
" http://www.reddit.com/r/vim/comments/1vdrxg/space_is_a_big_key_what_do_you_map_it_to/
map <Space> <leader>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings {{{
"
" Note: Plugins are not loaded at this point... don't know why, but stuff
" like:
" if exists(":Tabularize")
" Does not work...

" MiniBufExplorer
let g:miniBufExplUseSingleClick = 1 " If you would like to single click on tabs rather than double clicking on them to goto the selected buffer.
let g:miniBufExplCycleArround = 1   " Should buffer be cycled arround if hits the begining or the end while using MBE's buffer movement commands.
let g:miniBufExplBRSplit = 0        " Put new window above, else splitbelow is used
noremap <C-TAB> :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>

" UltiSnips
" First one is from snipMate
let g:snips_author = 'Henrik Farre <hf@bellcom.dk>'
let g:UltiSnipsExpandTrigger="<s-space>"
let g:UltiSnipsJumpForwardTrigger="<s-space>"
let g:UltiSnipsJumpBackwardTrigger="<c-s-space>"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

" Exuberant Ctags
" au BufWritePost *.php call system("ctags -a -f ~/tmp/dev/ctags/php --PHP-kinds=+cf --extra=+q " . expand("%:p"))
" au BufRead,BufNewFile *.php setlocal tags+=~/tmp/dev/ctags/php
" Set tag filename(s)
set tags+=~/.vim/phptags,./tags,tags
" set tags=./tags;${HOME}

" Load a tag file
" Loads a tag file from ~/.vim.tags/, based on the argument provided. The
" command "Ltag"" is mapped to this function.
function! LoadTags(file)
   let tagspath = $HOME . "/.vim-tags/" . a:file
   let tagcommand = 'set tags+=' . tagspath
   execute tagcommand
endfunction
command! -nargs=1 Ltag :call LoadTags("<args>")

" showmarks
" let g:showmarks_enable = 0
" let g:showmarks_ignore_type="hqpr"
" let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

" Disable plugins:
let g:loaded_html_danish = 1      " html_da
let g:loaded_netrwPlugin = 1      " netrw
let g:loaded_vimballPlugin = 1    " vimball
let loaded_matchparen = 1         " Parenthesis matching is just too slow

if !has("python3") 
  let g:UltiSnipsNoPythonWarning = 1
endif

" NERDTree
let NERDTreeSortOrder = [ '\/$', '*']

" Tag list
" let Tlist_Use_Right_Window = 1    " split to the right side of the screen
" let Tlist_Compart_Format = 1      " show small menu
" let Tlist_Enable_Fold_Column = 1  " Do not show folding tree
" let Tlist_Auto_Highlight_Tag = 1
" let Tlist_Display_Tag_Scope = 1
" let Tlist_Show_Menu = 1

" Zencoding aka emmet
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

" syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
" let g:syntastic_quiet_warnings=1
" let g:loaded_javascript_syntax_checker = 1 " Disable distribued javascript syntax checker plugin
" let g:syntastic_html_checker='w3' " use validator.w3.org
" let g:syntastic_csslint_options = "--warnings=none"

if &diff
  let g:loaded_javascript_syntax_checker = 1 " Disable hacked javascript syntex checker pluing if we are doing a diff
  let g:loaded_html_syntax_checker = 1 " Disable html
  let g:loaded_xhtml_syntax_checker = 1 " Disable xhtml
endif

" SuperTab
" let g:SuperTabDefaultCompletionType = "context"
" let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
" let g:SuperTabLongestHighlight = 1 

" Command-T
" Remember to: rake make in dir
" let g:CommandTMaxDepth = 4

" CtrlP
" https://github.com/kien/ctrlp.vim
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn|cache)$',
    \ 'file': '\v\.(exe|so|dll|tgz|tar|zip|log)$',
	\ }
" r:  the nearest ancestor that contains one of these directories or files: .git  .hg .svn .bzr _darcs
" a: like c, but only if the current working directory outside of CtrlP is not a direct ancestor of the directory of the current file.
let g:ctrlp_working_path_mode = 'ra'

" Quickly open the command-line CtrlP plugin.
nmap <C-q> :CtrlPCmdline<CR>

" From http://robots.thoughtbot.com/faster-grepping-in-vim
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Tabular
" if exists(":Tabularize")
  nmap <leader>a= :Tabularize /=<CR>
  vmap <leader>a= :Tabularize /=<CR>
  nmap <leader>a: :Tabularize /:\zs<CR>
  vmap <leader>a: :Tabularize /:\zs<CR>
" endif

" YouCompleteMe
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_auto_trigger = 1
let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1

" Vdebug
let g:vdebug_keymap =  {"run": "<F11>"}
let g:vdebug_options = {"path_maps": {"/var/www": "/home/enrique/Localdev/www"}, "break_on_open": 0, "watch_window_style": "compact", "server" : "172.17.42.1"}

" Tern for vim
let g:tern#command = ['tern'] " it is installed via npm, and the command is in PATH

" Gist vim
let g:gist_detect_filetype = 1
let g:gist_show_privates = 1
let g:gist_get_multiplefile = 1

" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" Scratch
nnoremap <Leader>s :Scratch<CR>

" vim-expand-region 
" https://github.com/terryma/vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding
"
set encoding=utf-8
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

set printfont=Bitstream\ Vera\ Sans\ Mono\ 8

" Invisible character
nmap <leader>l :set list!<CR>   " Shortcut to rapidly toggle `set list`
"set list
set listchars=tab:▸\ ,eol:¬

"vertical/horizontal scroll off settings
set scrolloff=10                  " Keep lines between the cursor and bottom/top
set sidescrolloff=7
set sidescroll=1

set shortmess=aTI                 " No "welcome" message

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
"set clipboard+=unnamed            " put yanks/etc on the clipboard
" 703 corresponds to Vim 7.3 
if v:version >= 703
  " use X clipboard
  set clipboard=unnamedplus
endif
set confirm                       " present a dialog
set display+=lastline             " A nicer way to show long wrapped lines
set title                         " change the terminals/windows title
set hid                           " change buffer without saving
set autowrite                     " Write contents of the file, if it has been modified, on buffer exit
set history=10000                 " remember more than the default 20 commands and search patterns
set shell=bash\ --rcfile\ ~/.vim/bashrc.vim
set virtualedit=block             " Allow the cursor to go in to 'invalid' places
set showcmd                       " Show (partial) command in status line.
set showmode                      " display the current mode
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set showfulltag                   " Show full tag for completion
set switchbuf=useopen             " Buffer switching the reuses already visible buffers
set formatoptions=tcqor	          " t=text, c=comments, q=format with gq command, o,r=autoinsert comment leader
set ttyfast                       " Indicates a fast terminal connection. More characters will be sent to the screen for redrawing

set modeline                      " read settings for stuff like shiftwidth from current file
set modelines=3                   " number lines checked for modelines

if has("gui_running")
  set noesckeys                   " Get rid of the delay when hitting esc!, NOTE: this produces A,B,C,D in input mode using arrow 
endif

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
set wildignore+=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,*/.git/*,*/.hg/*
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
set backupdir=/tmp/backups/   
set directory=/tmp/swaps/             " swap files
" set viewdir=~/.vim/views/
" Creating directories if they don't exist
silent execute '!mkdir -p /tmp/backups'
silent execute '!mkdir -p /tmp/swaps'
" silent execute '!mkdir -p ~/.vim/views'
" au BufWinLeave * silent! mkview         " make vim save view (state) (folds, cursor, etc)
" au BufWinEnter * silent! loadview       " make vim load view (state) (folds, cursor, etc)

" Use less space for line numbering if possible
if v:version >= 700
    try
        setlocal numberwidth=3
    catch
    endtry
endif

" if v:version >= 703
"     " tells Vim to create <FILENAME>.un~ files whenever you edit a file. These files contain undo information so you can undo previous actions even after you close and reopen a file.
"     set undofile
"     set undodir=~/.vim/undo,~/tmp,/tmp
" endif

if v:version < 700
  let loaded_nerd_tree=1
endif

set keymodel=startsel             " Allow select of text in insert mode using shift

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlightning
"
syntax on                         " Enable syntax highlightning
" filetype plugin on                " Enable filetype settings
filetype indent on
set synmaxcol=2048                " Syntax coloring lines that are too long just slows down the world

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
set smartindent                   " insert tabs on the start of a line according to shiftwidth, not tabstop
set copyindent                    " copy the previous indentation on autoindenting
set preserveindent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" functions
"

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

" Sudo write (from http://git.tpope.net/tpope.git?a=blob&f=.vimrc )
command! -bar -nargs=0 SudoW   :silent exe "write !sudo tee % >/dev/null"|silent edit!

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

" Switch *.php filetype based on rest of filename
" Based on vimrc from http://www.shlomifish.org/open-source/projects/conf/vim/current/vimrc
function! PHP_file_type()
    let fn = expand("<afile>")
    if (match(fn, "\\.ini\\.append\\.php$") >= 0)
        set filetype=ezpini
    else
        set filetype=php
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymaps
"

" More natural cursor movement
map <silent> <up> gk
imap <silent> <up> <C-o>gk
map <silent> <down> gj
imap <silent> <down> <C-o>gj
map <silent> <home> g<home>
imap <silent> <home> <C-o>g<home>
map <silent> <end> g<end>
imap <silent> <end> <C-o>g<end>

noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

" Easier split navigations
" http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Disable search highlightning
nmap <silent> <C-N> :silent noh<CR>

" toggle insertmode
" inoremap <S-Space> <ESC>
" nnoremap <S-Space> i

" Save keystrockes on save
" http://vim.wikia.com/wiki/Use_Ctrl-O_instead_of_Esc_in_insert_mode_mappings
imap <C-s> <C-o>:wa<CR>
nmap <C-s> :wa<CR>

" Quit
imap <C-q> <esc>:qa<CR>

" inoremap <C-space> <C-x><C-o>

" " Completion popup
" " Improve completion popup menu http://vim.wikia.com/wiki/Improve_completion_popup_menu
" inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
" inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
" inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
" inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
" inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
" inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
" " automatically open and close the popup menu / preview window
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" <F3> used in ~/.vim/ftplugin/php.vim
" mapning to jump to a line
" map <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" NERD Commenter
map <F5> :call NERDComment(0, 'toggle')<CR>
inoremap <F5> <C-o>:call NERDComment(0, 'toggle')<C-m>

" NERD Tree
map <F6> :NERDTreeToggle<CR>
" Tagbar
nmap <F8> :TagbarToggle<CR>
" Use Ack to search for word under cursor
" map <F9> <Esc>:exec("Ack --php ".expand("<cword>"))<CR>

" Conflicts with vdebug
" Set a toggle for pasting input
" set pastetoggle=<F10>

" Map ' so it jumps to line and column
nnoremap ' `
nnoremap ` '

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
" For command mode:
map! <S-Insert> <MiddleMouse>

"  Useful mappings to paste and reformat/reindent
" nnoremap <Esc>P P'[v']=
" nnoremap <Esc>p p'[v']=

" mistypings...
nmap :w:w :w
nmap :W :w
nmap :_w :w
nmap :Q :q
nmap :q1 :q!
nmap :qA :qa
nmap :wQ :wq
nmap :WQ :wq
nmap :Wq :wq
nmap :Wqa :wqa
nmap :E :e
nmap :Bw :bw
nmap :Bd :bd
nmap :B1 :b1
nmap :B2 :b2
nmap :Bn :bn
nmap :Sp :sp
" Disable Ex mode
map Q <Nop>
" Disable help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap gF :view <cfile><cr>     " Open none existing file under cursor

"Actually, the tab does not switch buffers, but my arrows
"Bclose function ca be found in "Buffer related" section
map <leader>bd :Bclose<cr>

noremap Y y$ " yank till the end of the line
" Yank/paste to the OS clipboard with ,y and ,p
" nmap <leader>y "*y
" nmap <leader>Y "*yy
" nmap <leader>p "*p
" nmap <leader>P "*P
" noremap  y "*y
" noremap  Y "*Y
" noremap  p "*p
" noremap  P "*P
" vnoremap y "*y
" vnoremap Y "*Y
" vnoremap p "*p
" vnoremap P "*P
" map <C-Z> :shell " Disable the suspend for ^Z ; call shell
" map <leader>cd :cd %:p:h<cr> "For changing to the current directory of the file I'm working on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbrevs
"

" ab Sop System.out.println();<left><left>
ab seperator separator
iab DATE <C-r>=strftime("%Y-%m-%d")<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Omnicomplete
"
" if version > 640
augroup vimrc_autocmd
  autocmd!
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType html,markdown set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType xhtml set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType ruby set omnifunc=rubycomplete#Complete

  set completeopt=menu,longest,preview 
" set completeopt=longest,menuone
augroup END
"endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer commands
"

" Go back to the position the cursor was on the last time this file was edited
" au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")|execute("normal `\"")|endif

" Load PHP files as php+html+css
" au BufRead,BufNewFile *.php set filetype=php.html.css
au BufRead,BufNewFile *.php call PHP_file_type()
" au BufRead,BufNewFile *.tpl set filetype=smarty.html.css

" Reads the skeleton files, delete empty line
if !&diff
  augroup vimrc_skeleton
    autocmd!
    autocmd BufNewFile *.php 0r ~/.vim/skel/php |normal Gdd2h 
    autocmd BufNewFile *.html 0r ~/.vim/skel/html | $,$d
    autocmd BufNewFile *.html setlocal ft=xhtml 
    autocmd BufNewFile *.css 0r ~/.vim/skel/css | $,$d
  augroup END
endif

" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff <wouter@blub.net>
augroup encrypted
  au!
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

" Drupal modules
augroup vimrc_drupalmodule
  autocmd!
  autocmd BufRead,BufNewFile *.module set filetype=php
  autocmd BufRead,BufNewFile *.install set filetype=php
  autocmd BufRead,BufNewFile *.test set filetype=php
augroup END

augroup vimrc_markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source files
"
source ~/.vim/ui.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn off any existing search
au VimEnter * nohls
