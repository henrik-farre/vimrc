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
noremap Y y$

" Yank / Paste multiple lines easier
" Automatically jump to end of text you pasted
" http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

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

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif
