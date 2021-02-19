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
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Font and terminal settings
" https://gist.github.com/romainl/9ecd7b09a693816997ba
" 'set t_Co=256' is a bad idea, set your terminal emulator up properly

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
if (has("termguicolors"))
 set termguicolors
  " Colorizer setup - requires termguicolors
  lua require'colorizer'.setup()
endif
colorscheme wombat256mod

" SignColumn
hi SignColumn guibg=#121212 ctermbg=232

" Neovim highlight group to yanked content
hi HighlightedyankRegion cterm=reverse gui=reverse

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

function! AirlineGitInfo()
  let git = fugitive#head()
  if git != ''
    return ' '.git
  else
    return ''
endfunction

let g:airline_powerline_fonts = 1
let g:airline_theme = 'jellybeans'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tabline#enabled = 0
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
