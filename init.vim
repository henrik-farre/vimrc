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

" Disable unused providers
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0

let $VIMHOME = split(&rtp, ',')[0] " Find the Vim path

if has('vim_starting')
  " ensure that we always start with Vim defaults (as opposed to those set by the current system)
  " Save 'diff' as set all& resets it, from http://ruderich.org/simon/config/vimrc
  let s:save_diff = &diff
  " Disabled to fix lack of nvim resize, see https://github.com/neovim/neovim/issues/11066
  " - also it should not be needed for neovim https://github.com/neovim/neovim/issues/5783

  " Some Arch Linux packages (tmux, docker) install syntax and more in the following path
  set runtimepath+=/usr/share/vim/vimfiles
endif

if has('eval')
  let &diff = s:save_diff
  unlet s:save_diff
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding
"
scriptencoding utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"
lua <<EOF
if vim.loop.os_uname().machine == "aarch64" then
  vim.cmd('source $VIMHOME/plugins-light.vim')
else
  vim.cmd('source $VIMHOME/plugins.vim')
end
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader
" Needs to be set here, and not in bindings.vim as it is sourced to late
" http://www.reddit.com/r/vim/comments/1vdrxg/space_is_a_big_key_what_do_you_map_it_to/
"
let g:mapleader = "\<Space>"
map <Space> <Leader>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
if has_key(g:plugs, 'fzf') && executable('fzf')
  " Dont use tmux split
  " https://github.com/junegunn/fzf.vim/issues/66#issuecomment-169362556
  " let g:fzf_layout = {}
  let g:fzf_nvim_statusline=1
  " Override env from shell where I prefer -e
  let $FZF_DEFAULT_OPTS = '-x --inline-info'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips
"
let g:snips_author = 'Henrik Farre <henrik@rockhopper.dk>'
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable plugins:
"
let g:loaded_html_danish = 1      " html_da
let g:loaded_netrwPlugin = 1      " netrw
let g:loaded_vimballPlugin = 1    " vimball
let g:loaded_matchparen = 1       " Parenthesis matching is just too slow
let g:loaded_gzip = 1
let g:loaded_tarPlugin = 1
let g:loaded_zipPlugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_matchit = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Emmet
"
let g:user_emmet_expandabbr_key = '<c-e>'
let g:user_emmet_complete_tag = 1
let g:user_emmet_settings = {
      \ 'html' : {
      \   'filters' : 'html',
      \   'indentation' : ' '
      \ },
      \ 'css' : {
      \   'filters' : 'fc',
      \ }
      \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable syntax checking when in a diff
"
if &diff
  set noswapfile
  let g:loaded_javascript_syntax_checker = 1
  let g:loaded_html_syntax_checker = 1
  let g:loaded_xhtml_syntax_checker = 1
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delimitMate
"
" let delimitMate_expand_cr = 1
" let delimitMate_expand_space = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERD Commenter
"
let g:NERDCreateDefaultMappings = 0
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JSON
" Don't hide "
let g:vim_json_syntax_conceal = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quick-scope
"
" let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ansible settings
" When this variable is set, indentation will completely reset (unindent to column 0) after two newlines in insert-mode. The normal behavior of YAML is to always keep the previous indentation, even across multiple newlines with no content.
"
let g:ansible_unindent_after_newline = 0
let g:ansible_ftdetect_filename_regex = '\v(playbook|site|local|requirements)\.ya?ml$'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terraform settings
"
let g:terraform_fmt_on_save=1       " Run terraform fmt on save to comply with style guide
let g:terraform_align=1             " Set indent to 2 spaces

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DevIcons (use for vim-airline)
"
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['zsh'] = ''
" ryanoasis/vim-devicons contains an explicit setting for .zshrc: https://github.com/ryanoasis/vim-devicons/blob/master/plugin/webdevicons.vim#L300
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['.zshrc'] = ''

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup for lua plugins
"
lua <<EOF
------------------------------------------------------------
-- nvim-web-devicons also has a override for .zshrc https://github.com/kyazdani42/nvim-web-devicons/blob/master/lua/nvim-web-devicons.lua#L175
-- (used by telescope, trouble and more)
--
if vim.g.plugs['nvim-web-devicons'] then
  require'nvim-web-devicons'.setup {
    override = {
      [".zshrc"] = {
        icon = "",
        color = "#428850",
        name = "Zsh"
      }
    };
  default = true;
  }
end

if vim.g.plugs['neogen'] then
  require('neogen').setup {
    input_after_comment = true,
    languages = {
      python = {
        template = {
          annotation_convention = "numpydoc"
        }
      }
    }
  }
end

-- LSP setup
-- LSP kind
-- LSP colors
-- Trouble
require('config.lsp')
-- Treesitter
require('config.treesitter')
-- Telescope
-- require('config.telescope')
-- Indent blankline
-- Project
-- Todo Comments
-- Dressing
require('config.plugins')
-- nvim cmp
require('config.cmp')
-- lua functions
require('config.functions')

-- Only spell check inside comments
-- require('spellsitter').setup()

-- Auto complete pairs
if vim.g.plugs['nvim-autopairs'] then
  require("nvim-autopairs").setup {}
end

if vim.g.plugs['lualine.nvim'] then
require('lualine').setup {
  options = {
    theme = 'jellybeans',
  }
}
end

if vim.g.plugs['nvim-bqf'] then
  require('bqf').setup {}
end

if vim.g.plugs['leap.nvim'] then
  require('leap').add_default_mappings()
end
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Peekaboo
"
" Increase size of window
if has_key(g:plugs, 'vim-peekaboo')
  let g:peekaboo_window = "vert bo 70new"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy clip
"
if has_key(g:plugs, 'vim-easyclip')
  let g:EasyClipAlwaysMoveCursorToEndOfPaste = 1
  let g:EasyClipPreserveCursorPositionAfterYank = 1
  let g:EasyClipUseCutDefaults = 0
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Encoding
"
set fileencodings=utf-8,iso-8859-1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
"
set ignorecase                    " Do case insensitive matching, must be set for smartcase to work
set smartcase                     " Do smart case search - case sensitive if first letter in search is uppercase
set inccommand=split              " Incremental replace, https://github.com/neovim/neovim/pull/5561
set gdefault                      " Applies substitutions globally on lines, /g to disable

set infercase                     " Handle case in a smart way in autocompletes
set lazyredraw                    " Speed up macros

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding rules
"
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
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
set signcolumn=yes:1              " Always show 1 sign column

set list
" set listchars=tab:▸\ ,eol:¬
set listchars=tab:\ \ ,extends:»,precedes:«,nbsp:·

"vertical/horizontal scroll off settings
set scrolloff=10                  " Keep lines between the cursor and bottom/top
set sidescrolloff=7
" All abbrevitions, truncate middle of long messages, no intro when starting,
set shortmess=aTI
" no ins-completion-menu messages
set shortmess+=c


" Keep windows stable when opening trouble and more
if exists('*splitkeep')
  set splitkeep=cursor
endif

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
set breakindent                   " visually indent text: http://www.reddit.com/r/vim/comments/2jjtad/this_picture_says_it_all_thanks_to_uchrisbra10/
set confirm                       " present a dialog
set display+=lastline             " A nicer way to show long wrapped lines
set title                         " change the terminals/windows title
set hid                           " change buffer without saving
set autowrite                     " Write contents of the file, if it has been modified, on buffer exit
set virtualedit=block             " Allow the cursor to go in to 'invalid' places in visual block mode
set showmode                      " display the current mode
" set fillchars=vert:\ ,stl:\ ,stlnc:\ 
set fillchars+=vert:│
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

" Do not autoread changed files (still detect changes) https://github.com/neovim/neovim/issues/2127
set noautoread

" Automatically change to directory of current file
" - fixes start location of telescope find files
" - Use rooter instead
" set autochdir

" Avoid adding newline to last line of file
set binary noeol

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clipboard
"
" In insert mode:
" - <C+r> *: Primary selection
" - <C+r> +: Contents of clipboard
"
" use X clipboard if avaliable
" let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'
" Make it work in Neovim
if (has('clipboard') && executable('xsel') && exists('$DISPLAY'))
  set clipboard+=unnamedplus
elseif (has('clipboard') && executable('wl-copy'))
  " wayland support
  set clipboard+=unnamedplus
elseif (has('clipboard') && executable('pbcopy') && has('mac'))
  set clipboard+=unnamedplus
endif

set modeline                      " read settings for stuff like shiftwidth from current file
set modelines=3                   " number lines checked for modelines

if has("gui_running")
  set noesckeys                   " Get rid of the delay when hitting esc!, NOTE: this produces A,B,C,D in input mode using arrow
endif

" set completeopt+=menu,longest,preview
set completeopt=menu,menuone,noselect
set complete-=i                   " disabled scanning of include files

" spelling
set spellsuggest=best,9
set spell
set spelllang=en
set spelloptions+=noplainbuffer,camel

" Wrapping/linebreak
set textwidth=0                   " Do not wrap text
set linebreak                     " Do not softwrap the line in the middle of a word
set whichwrap=<,>,[,],h,l,b,s,~   " Make end/beginning-of-line cursor wrapping behave human-like, not vi-like

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

" Use less space for line numbering if possible
try
  setlocal numberwidth=3
catch
endtry

set keymodel=startsel             " Allow select of text in insert mode using shift

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlightning
"
set synmaxcol=500                " Syntax coloring lines that are too long just slows down the world

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Diff
"
set diffopt+=iwhite,linematch:60,algorithm:patience " Ignore whitespace, Enable a second stage diff on each generated
                                                    " hunk in order to align lines
                                                    " Use patience diff algorithm
set diffexpr=""                                     " When 'diffexpr' is empty, Vim uses this command to find the differences between file1 and file2: diff file1 file2 > outfile

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
" Disable smartindent
" http://stackoverflow.com/questions/18415492/autoindent-is-subset-of-smartindent-in-vim/18415867#18415867
" http://vim.wikia.com/wiki/Indenting_source_code#Methods_for_automatic_indentation
" set smartindent                   " insert tabs on the start of a line according to shiftwidth, not tabstop
set copyindent                    " copy the previous indentation on autoindenting
set preserveindent

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
augroup vimrc_number
  autocmd!
  autocmd FocusLost * :set norelativenumber
  autocmd FocusGained * :set relativenumber
  autocmd InsertEnter * :set norelativenumber
  autocmd InsertLeave * :set relativenumber
augroup END

" Only show cursorline in active window/buffer
augroup vimrc_CursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=500, on_visual=true}

if has_key(g:plugs, 'nvim-lightbulb')
" Show 💡 when code action is avaliable
augroup vimrc_lightbulb
  autocmd!
  autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb({ ignore = {"null-ls"} })
augroup END
endif

" Reads the skeleton files, delete empty line
if !&diff
  augroup vimrc_skeleton
    autocmd!
    autocmd BufNewFile *.module 0r $VIMHOME/skel/drupal_module |normal Gdd2h
    autocmd BufNewFile *.info 0r $VIMHOME/skel/drupal_info |normal Gdd2h
    autocmd BufNewFile *.html 0r $VIMHOME/skel/html | $,$d
    autocmd BufNewFile *.css 0r $VIMHOME/skel/css | $,$d
    autocmd BufNewFile *.sh 0r $VIMHOME/skel/bash | $,$d
    autocmd BufNewFile Dockerfile 0r $VIMHOME/skel/Dockerfile | $,$d
    autocmd BufNewFile .dockerignore 0r $VIMHOME/skel/dockerignore | $,$d
    autocmd BufNewFile hest.yml 0r $VIMHOME/skel/hest.yml | $,$d
    autocmd BufNewFile pyrightconfig.json 0r $VIMHOME/skel/pyrightconfig.json | $,$d
    autocmd BufNewFile .vimspector.json 0r $VIMHOME/skel/vimspector.json | $,$d
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
    autocmd BufNewFile,BufRead *.md,*.markdown :call MarkdownTypeDetect()
augroup END

" Fix that after enter the key is indented, and LSP does not suggest anything,
" key is reindented after pressing :
augroup vimrc_yaml
    autocmd!
    autocmd FileType yaml.ansible setlocal indentexpr=
augroup END

" ansible-vim does not detect playbooks, `set filetype=x` overrides setfiletype
augroup vimrc_ansible
    autocmd!
    autocmd BufRead,BufNewFile */[aA]nsible/*.{yml,yaml} set filetype=yaml.ansible
    autocmd BufRead,BufNewFile inventory set filetype=ansible_hosts
augroup END

" Jenkinsfile
augroup vimrc_jenkins
  autocmd!
  autocmd BufNewFile,BufRead Jenkinsfile setfiletype groovy
augroup END

augroup vimrc_whitespace
  autocmd!
  autocmd FileWritePre    *.{js,module,info,tpl,md} :call TrimWhiteSpace()
  autocmd FileAppendPre   *.{js,module,info,tpl,md} :call TrimWhiteSpace()
  autocmd FilterWritePre  *.{js,module,info,tpl,md} :call TrimWhiteSpace()
  autocmd BufWritePre     *.{js,module,info,tpl,md} :call TrimWhiteSpace()
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI settings
"
source $VIMHOME/ui.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymaps
"
source $VIMHOME/bindings.vim