""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window titles
"
" Term
if &term =~ "^screen"
" has("autocmd")
" autocmd VimLeave * :set term=screen " this fixes background artifacting when leaving vim inside screen
  set t_ts=k
  set t_fs=\
endif

" Tries to match statusline
if has('title')
  set titlestring=%{v:progname}:\ 
  " git branch
  " %{exists('g:loaded_fugitive')?fugitive#titlestring():''}
  set titlestring+=%{fugitive#statusline()}
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

  " display a warning if file encoding isnt utf-8
  " Syntastic Warning
  set titlestring+=%{SyntasticStatuslineFlag()} 
  set titlestring+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Font and terminal settings
"
if has("gui_running")
  set guifont=Envy\ Code\ R\ 9
  " set guifont=M+\ 2m\ regular\ 9
  " set guifont=Envy\ Code\ R\ for\ Powerline\ 9
  set guioptions=ai " a: primary selection, i: icon 
elseif ( &term =~ '^xterm' || &term =~ '^rxvt-' || &term =~ '^screen-')
  " set background=dark " Only when running as terminal
  " Terminal options
  set t_Sb=^[4%dm " set background color
  set t_Sf=^[3%dm " set foreground color
  set t_Co=256    " Number of colors
                  " bce = background color erase
  if ( &term == 'screen-256color-bce' )
    set t_ut=
  endif
else
  "set background=dark
  set t_Co=16
  "colorscheme darkblue
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
"
" http://www.vim.org/scripts/script.php?script_id=2465
" colorscheme wombat256
colorscheme wombat256mod

" set cursorline  " Highlight current line
" hi cursorline guibg=#000070
" Highlight current line in insert mode.
" autocmd InsertLeave * se nocul
" autocmd InsertEnter * se cul 
" hi CursorColumn guibg=#ff0050
hi Pmenu        guifg=#00ffff guibg=#000000            ctermbg=0 ctermfg=6
hi PmenuSel     guifg=#ffff00 guibg=#000000 gui=bold   cterm=bold ctermfg=3
hi PmenuSbar    guibg=#204d40                          ctermbg=6
hi PmenuThumb   guifg=#38ff56                          ctermfg=3
hi WildMenu     guifg=#20012e guibg=#00a675 gui=bold   ctermfg=NONE ctermbg=NONE cterm=bold
 
" MiniBufExplorer
hi MBENormal            guifg=#cfbfad
hi MBEChanged           guifg=#ffffff guibg=#ff0000
hi MBEVisibleNormal     guifg=#cfcfcd gui=bold cterm=bold
hi MBEVisibleChanged    guifg=#ffffff guibg=#ff0000 gui=bold cterm=bold
 
" Invisible character colors
" Disabled because it changes gutter color in wombat256
" hi NonText guifg=#161640
" hi SpecialKey guifg=#161640

" For statusline
hi User1 guifg=#eee040
hi User2 guifg=#dd3333
hi User3 guifg=#ff66ff
hi User4 guifg=#a0ee40
hi User5 guifg=#eeee40

" SignColumn
hi SignColumn guibg=#121212

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Behavior
set selection=inclusive " Selection will include current char, set to exclusive else
set mousemodel=popup
if has("gui_running")
  set mouse=ar          " Mouse on, all modes + hit-enter/more-prompt
else
  set mouse=iv            " Mouse on, insert, visual
endif

set cmdheight=1         " The commandbar is 1 high

if &diff
  " Fixes "press enter or type command to continue"
  set cmdheight=2
  " http://vim.wikia.com/wiki/Start_with_a_wide_window_for_diff
  let &columns = 320 + 2*&foldcolumn + 1
endif

" Highlight redundant whitespaces.
" hi RedundantSpaces ctermbg=blue guibg=blue
" match RedundantSpaces /\s\+$\| \+\ze\t/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline 
"
" n: Buffernumber 
set statusline=[%n]\ 
" git branch
" %{exists('g:loaded_fugitive')?fugitive#statusline():''}
set statusline+=%1*
set statusline+=%{fugitive#statusline()}
set statusline+=%*
" set statusline+=\ %F\ 
" Display min 25, max 60 chars of F (Full path), from the right
set statusline+=\ %-25.60F\ 
" r: Read only flag
" y: Filetype
" m: Modified flag 
set statusline+=%r%y%m
 
" display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

" display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
" Syntastic Warning
set statusline+=%{SyntasticStatuslineFlag()} 
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*
 
" display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=\ %l,%c%V\ %<%P

set laststatus=2                  " Always show statusline
