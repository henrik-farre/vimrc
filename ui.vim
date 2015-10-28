""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Window titles
"
" Term
" if &term =~ "^screen"
" " has("autocmd")
" " autocmd VimLeave * :set term=screen " this fixes background artifacting when leaving vim inside screen
"   set t_ts=k
"   set t_fs=\
" endif

" Highlight VCS conflict markers
" Based on https://bitbucket.org/sjl/dotfiles/src/141b96496989091fce4aa5165946f94d31c2374f/vim/vimrc
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" allows cursor change in tmux mode
" https://github.com/rafi/vim-config/blob/master/config/terminal.vim
" http://dougblack.io/words/a-good-vimrc.html#tmux
"if exists('$TMUX')
"  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[3 q\<Esc>\\"
"  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[0 q\<Esc>\\"
"endif

" Might create problems with normal term
" rxvt-256color is for launcing nvim directly with out tmux
" if &term == 'xterm-256color' || &term =~ '^screen' || &term =~ '^rxvt-'
"   " Cursor shape
"   " ------------
"   " For rxvt-unicode:
"   " 1 or 0 -> blinking block
"   " 2 -> solid block
"   " 3 -> blinking underscore
"   " 4 -> solid underscore
"   " Recent versions of xterm (282 or above) also support
"   " 5 -> blinking vertical bar
"   " 6 -> solid vertical bar
"   let &t_SI = "\<Esc>[6 q"
"   let &t_EI = "\<Esc>[2 q"
"   " let &t_EI = "\<Esc>]12;white\x9c"
"   " let &t_SI = "\<Esc>]12;orange\x9c"
" endif

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

  " display a warning if file encoding isnt utf-8
  " Syntastic Warning
  if has_key(g:plugs, 'syntastic')
    set titlestring+=%{SyntasticStatuslineFlag()}
    set titlestring+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Font and terminal settings
" https://gist.github.com/romainl/9ecd7b09a693816997ba
" 'set t_Co=256' is a bad idea, set your terminal emulator up properly
" instead.
"
"  if has("gui_running")
"    set guifont=Envy\ Code\ R\ 9
"    " set guifont=M+\ 2m\ regular\ 9
"    " set guifont=Envy\ Code\ R\ for\ Powerline\ 9
"    set guioptions=ai " a: primary selection, i: icon
"  elseif ( &term =~ '^xterm' || &term =~ '^rxvt-' || &term =~ '^screen-')
"    " set background=dark " Only when running as terminal
"    " Terminal options
"    set t_Sb=^[4%dm " set background color
"    set t_Sf=^[3%dm " set foreground color
"    set t_Co=256    " Number of colors
"                    " bce = background color erase
"    if ( &term == 'screen-256color-bce' )
"      set t_ut=
"    endif
"  else
"    "set background=dark
"    set t_Co=16
"    "colorscheme darkblue
"  endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
colorscheme wombat256mod

" set cursorline  " Highlight current line
" hi cursorline guibg=#000070
" Highlight current line in insert mode.
" autocmd InsertLeave * se nocul
" autocmd InsertEnter * se cul 
" hi CursorColumn guibg=#ff0050
"     hi Pmenu        guifg=#00ffff guibg=#000000            ctermbg=0 ctermfg=6
"     hi PmenuSel     guifg=#ffff00 guibg=#000000 gui=bold   cterm=bold ctermfg=3
"     hi PmenuSbar    guibg=#204d40                          ctermbg=6
"     hi PmenuThumb   guifg=#38ff56                          ctermfg=3
"     hi WildMenu     guifg=#20012e guibg=#00a675 gui=bold   ctermfg=NONE ctermbg=NONE cterm=bold
"
" MiniBufExplorer
hi MBENormal            guifg=#cfbfad
hi MBEChanged           guifg=#ffffff guibg=#ff0000
hi MBEVisibleNormal     guifg=#cfcfcd gui=bold cterm=bold
hi MBEVisibleChanged    guifg=#ffffff guibg=#ff0000 gui=bold cterm=bold
"
"     " Invisible character colors
"     " Disabled because it changes gutter color in wombat256
"     " hi NonText guifg=#161640
"     " hi SpecialKey guifg=#161640
"
"     " For statusline
"     hi User1 guifg=#eee040
"     hi User2 guifg=#dd3333
"     hi User3 guifg=#ff66ff
"     hi User4 guifg=#a0ee40
"     hi User5 guifg=#eeee40
"
"     " SignColumn
"     hi SignColumn guibg=#121212

" Make background consistent
" http://www.reddit.com/r/vim/comments/2lqagi/making_the_vim_background_consistent/
" highlight NonText guifg=fg guibg=bg ctermfg=fg ctermbg=bg gui=none cterm=none

" Indet guides
hi IndentGuidesOdd  ctermbg=236
hi IndentGuidesEven ctermbg=235

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Behavior
set selection=inclusive " Selection will include current char, set to exclusive else
set mousemodel=popup
set mouse=ar            " Mouse on, all modes + hit-enter/more-prompt
" Scroll in tmux
" https://news.ycombinator.com/item?id=4420173
" Was not set before
if !has('nvim')
  set ttymouse=xterm2
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
set statusline+=%1*
if has_key(g:plugs, 'fugitive')
  set statusline+=%{fugitive#statusline()}
endif
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
if has_key(g:plugs, 'syntastic')
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
  set statusline+=%*
endif

" display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=\ %l,%c%V\ %<%P

set laststatus=2                  " Always show statusline
