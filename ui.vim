""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cursor
"
" hi CursorLine guibg=#282828
" hi CursorLineNr guifg=Grey guibg=#282828
highlight Cursor guifg=white guibg=#0d61ac
highlight default CursorInsert guifg=white guibg=#437019
highlight default CursorVisual guifg=white guibg=#870000
set guicursor=a:blinkwait600-blinkoff450-blinkon500,sm:block-blinkwait175-blinkoff150-blinkon175
set guicursor+=n-c:block-Cursor,v:block-CursorVisual,i-ci-ve:ver25-CursorInsert,r-cr:hor20,o:hor50
set cursorline

" SignColumn
" hi SignColumn guibg=#121212 ctermbg=232
hi DiagnosticError guifg=red guibg=#111111
hi DiagnosticSignWarn guifg=yellow guibg=#111111
hi DiagnosticSignHint guifg=green guibg=#111111
hi DiagnosticSignInfo guifg=blue guibg=#111111
hi DiagnosticInfo guibg=#111111
" Change split background between windows
hi VertSplit guibg=NONE guifg=#444444 ctermbg=NONE ctermfg=NONE

" Indent guide
hi IndentBlanklineChar guifg=#2f2f2f gui=nocombine
" https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
set colorcolumn = "99999"

" Visual selection
hi Visual guifg=#000000 guibg=LightBlue gui=none

hi ExtraWhitespace guibg=#4e2f2f

" vim-signature
hi SignatureMarkText cterm=bold ctermbg=10 gui=bold guifg=#aeee04

" Make background consistent
" http://www.reddit.com/r/vim/comments/2lqagi/making_the_vim_background_consistent/
" highlight NonText guifg=fg guibg=bg ctermfg=fg ctermbg=bg gui=none cterm=none

" cmp highlighting - https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
" gray
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" pink
highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4

" Highlight VCS conflict markers
" Based on https://bitbucket.org/sjl/dotfiles/src/141b96496989091fce4aa5165946f94d31c2374f/vim/vimrc
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Behavior
set selection=inclusive " Selection will include current char, set to exclusive else
set mousemodel=popup
set mouse=ar            " Mouse on, all modes + hit-enter/more-prompt

set cmdheight=1         " The commandbar is 1 high

if &diff
  " Fixes "press enter or type command to continue"
  set cmdheight=2
  " Breaks rendering in neovim
  " http://vim.wikia.com/wiki/Start_with_a_wide_window_for_diff
  " let &columns = 320 + 2*&foldcolumn + 1
endif

set noshowmode
