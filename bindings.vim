""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General keymaps
"
" Plugin mappings are in vimrc
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

noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
noremap <buffer> <silent> 0 g0
noremap <buffer> <silent> $ g$

" Easier split navigations
" http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Pipe char is \, use CTRL-V to find it
" '-' can't be used
nnoremap <C-\> <C-W>v
nnoremap <C-_> <C-W>n

" Disable search highlightning
nmap <silent> <C-N> :silent noh<CR>

" Save keystrockes on save
" http://vim.wikia.com/wiki/Use_Ctrl-O_instead_of_Esc_in_insert_mode_mappings
imap <C-s> <C-o>:wa<CR>
nmap <C-s> :wa<CR>

" Map ' so it jumps to line and column
nnoremap ' `
nnoremap ` '

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
" For command mode:
map! <S-Insert> <MiddleMouse>

"  Useful mappings to paste and reformat/reindent
nnoremap <leader>P P'[v']=
nnoremap <leader>p p'[v']=

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
nmap :WQa :wqa
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

" Open none existing file under cursor
nnoremap gF :view <cfile><cr>

"Actually, the tab does not switch buffers, but my arrows
"Bclose function ca be found in "Buffer related" section
map <leader>bd :Bclose<cr>
