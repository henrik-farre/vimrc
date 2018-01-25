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

  if has('nvim')
    " Some Arch Linux packages (tmux, docker) install syntax and more in the following path
    set runtimepath+=/usr/share/vim/vimfiles
  endif
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
" Dependencies
" Remember to run 'make' in dir after install
" Plug 'Shougo/vimproc'
" Currently only needed by emmet-vim for snippet override
" Plug 'mattn/webapi-vim'
" Repeat plugin actions with "." only used by surround
" Plug 'tpope/vim-repeat'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Javascript
" JavaScript bundle for vim, this bundle provides syntax and indent plugins.
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" Remember to run npm install in folder
if executable('npm')
  Plug 'marijnh/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
endif
" Handlebars syntax + text objects:
" Plug 'mustache/vim-mustache-handlebars'
" JSON/JSONP
" Plug 'elzr/vim-json'
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
" Improved PHP omnicompletion -> breaks YCM somehow
" Plug 'shawncplus/phpcomplete.vim'
Plug 'joonty/vdebug'
" Needed by pdv
Plug 'tobyS/vmustache', { 'for': 'php' }
" PHP doc
Plug 'tobyS/pdv', { 'for': 'php' }
" Drupal enhancements
" https://www.drupal.org/node/1389448#vundle - with modifications, so don't update
" Plug 'git://drupalcode.org/project/vimrc.git', {'dir': 'drupal-vimrc', 'rtp': 'bundle/vim-plugin-for-drupal/', 'pinned': 1}
" Code sniffer fixer: <leader>pcf
" Pinned because of https://github.com/stephpy/vim-php-cs-fixer/issues/1
Plug 'stephpy/vim-php-cs-fixer', { 'for': 'php' }
" Slightly buggy, error about mark not being set
" nnoremap <unique> <Leader>rlv :call PhpRenameLocalVariable()<CR>
" nnoremap <unique> <Leader>rcv :call PhpRenameClassVariable()<CR>
" nnoremap <unique> <Leader>rm :call PhpRenameMethod()<CR>
" nnoremap <unique> <Leader>eu :call PhpExtractUse()<CR>
" vnoremap <unique> <Leader>ec :call PhpExtractConst()<CR>
" nnoremap <unique> <Leader>ep :call PhpExtractClassProperty()<CR>
" vnoremap <unique> <Leader>em :call PhpExtractMethod()<CR>
" nnoremap <unique> <Leader>np :call PhpCreateProperty()<CR>
" nnoremap <unique> <Leader>du :call PhpDetectUnusedUseStatements()<CR>
" vnoremap <unique> <Leader>== :call PhpAlignAssigns()<CR>
" nnoremap <unique> <Leader>sg :call PhpCreateSettersAndGetters()<CR>
" nnoremap <unique> <Leader>da :call PhpDocAll()<CR>
" Plug 'adoy/vim-php-refactoring-toolbox'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git
" Shows git branch in statusline + tags to the one in .git/tags if exists
if executable('git')
  Plug 'tpope/vim-fugitive'
endif
" Plug 'mattn/gist-vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Web
Plug 'mattn/emmet-vim'
" HTML5 omnicomplete and syntax
" Plug 'othree/html5.vim'
" Twig, correct filetype set by autocmd in this file
" Discontinued repository:
" Plug 'evidens/vim-twig'
" vim syntax for LESS (dynamic CSS)
" Plug 'groenewege/vim-less'
" Add CSS3 syntax support to vim's built-in `syntax/css.vim`
" Plug 'hail2u/vim-css3-syntax'
" Show CSS colors
" Plug 'skammer/vim-css-color'
" Smarty
" Plug 'blueyed/smarty.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
" Plug 'Shougo/neocomplete.vim'
if has('nvim') && has("python")
  Plug 'Valloric/YouCompleteMe', { 'do': 'python2 ./install.py' }
endif
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'Raimondi/delimitMate'
" Neovim buildin
if !has('nvim')
" Active repository?: https://github.com/Firef0x/matchit/network
Plug 'vim-scripts/matchit.zip'
endif
" Vim runtime files for Haml, Sass, and SCSS
" Plug 'tpope/vim-haml'
" Plug 'weynhamz/vim-plugin-minibufexpl'
" Plug 'fholgado/minibufexpl.vim'
" Plug 'ap/vim-buftabline'
Plug 'scrooloose/nerdcommenter'
Plug 'benekastah/neomake'
" Produces some strange sideeffects
" Meta-p / Meta-Shift-p after paste, needs to be loaded before surround
" Plug 'maxbrunsfeld/vim-yankstack'
Plug 'tpope/vim-surround'

" Plug 'rking/ag.vim'
" Plug 'mileszs/ack.vim'

if v:version >= 704
  Plug 'haya14busa/incsearch.vim'
endif

" Highlights on f F t F
Plug 'bradford-smith94/quick-scope'
" Dead repo:
"Plug 'unblevable/quick-scope'

" Plug 'vasconcelloslf/vim-interestingwords'
" Like poster for Chrome, make http requests
" Plug 'nicwest/QQ.vim'
" Add visual marks in gutter
Plug 'kshenoy/vim-signature'
Plug 'godlygeek/tabular'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorschemes
Plug 'michalbachowski/vim-wombat256mod'
" 24bit, too dim colors
" Plug 'tyrannicaltoucan/vim-deep-space'
" Plug 'mhartington/oceanic-next'
" 24bit, but too blueish
" Plug 'whatyouhide/vim-gotham'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'machakann/vim-highlightedyank'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tags
" https://github.com/majutsushi/tagbar/wiki
" Adding support for javascript:
" https://github.com/ramitos/jsctags
" npm install -g git://github.com/ramitos/jsctags.git
" Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP
" Plug 'kien/ctrlp.vim'
" Active fork:
" Plug 'ctrlpvim/ctrlp.vim'
" cmdline : cmdline history, yankring : yank history, menu : extension selector menu
" Plug 'sgur/ctrlp-extensions.vim.git'
" Plug 'JazzCore/ctrlp-cmatcher'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF, first repository contains plugin, the other commands and mappings
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Shows registers:
Plug 'junegunn/vim-peekaboo'
" Alternativ matcher written in python https://github.com/FelikZ/ctrlp-py-matcher
" Annoying when using mixed html/php
" See <leader>p
" Plug 'sickill/vim-pasta'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
" Examples of python interpolation:
" https://medium.com/brigade-engineering/sharpen-your-vim-with-snippets-767b693886db
" PHP/Symfony snippets: https://github.com/algotech/ultisnips-php
if v:version >= 704
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
endif
" Plug 'chrisbra/Recover.vim'
" Plug 'mtth/scratch.vim'
" Use v multiple times to expand selection
" Plug 'terryma/vim-expand-region'
" <Space>w
" <Space>fX where X is a char
" <Space>j/k linewise
" Plug 'Lokaltog/vim-easymotion'
" Plug 'christoomey/vim-tmux-navigator'
" Plug 'dyng/ctrlsf.vim'
" Ansible
Plug 'pearofducks/ansible-vim'
" Detect tabs vs spaces
Plug 'tpope/vim-sleuth'
" Syntax and more for tmux
Plug 'tmux-plugins/vim-tmux'
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
" Plugin settings {{{
"
" Note: Plugins are not loaded at this point... don't know why, but stuff
" like:
" if exists(":Tabularize")
" Does not work...

" Neocomplete {{{
" Use neocomplete.
" let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
"
" let g:neocomplete#auto_completion_start_length   = 2
" let g:neocomplete#manual_completion_start_length = 0
" let g:neocomplete#enable_auto_close_preview      = 1
" let g:neocomplete#enable_auto_select = 1
"
" " <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   " return neocomplete#close_popup() . "\<CR>"
"   " For no inserting <CR> key.
"   return pumvisible() ? neocomplete#close_popup() : "\<CR>"
" endfunction
"
" " Enable heavy omni completion.
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif
" if !exists('g:neocomplete#force_omni_input_patterns')
"   let g:neocomplete#force_omni_input_patterns = {}
" endif
" let g:neocomplete#sources#omni#input_patterns.php = '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
"
" " <TAB>: completion.
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"
"
" if has('conceal')
"   set conceallevel=2 concealcursor=i
" endif
" let g:neocomplete#max_list = 20
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MiniBufExplorer
" Use Ctrl+Pageup / Pagedown as Ctrl+Tab does not work in the urxvt
if has_key(g:plugs, 'vim-plugin-minibufexpl')
  let g:miniBufExplUseSingleClick = 1   " If you would like to single click on tabs rather than double clicking on them to goto the selected buffer.
  let g:miniBufExplCycleArround = 1     " Should buffer be cycled arround if hits the begining or the end while using MBE's buffer movement commands.
  let g:miniBufExplBRSplit = 0          " Put new window above, else splitbelow is used
  let g:miniBufExplorerMoreThanOne = 3  " Prevent problems with git difftool: https://github.com/fholgado/minibufexpl.vim/issues/17
  let g:miniBufExplorerAutoStart = 0    " Do not auto start
  noremap <C-TAB> :MBEbn<CR>
  noremap <C-S-TAB> :MBEbp<CR>
"  noremap <silent> [5^ :MBEbn<CR>
"  noremap <silent> [6^ :MBEbp<CR>
"  noremap <silent> <Leader>bn :MBEbn<CR>
"  noremap <silent> <Leader>bp :MBEbp<CR>
" FZF is used for that
"  noremap <leader>bt :MBEToggle<CR>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips
let g:snips_author = 'Henrik Farre <hfar@tv2.dk>'
let g:UltiSnipsEnableSnipMate = 0   " don't look for SnipMate snippets, in the 'snippets' dir
" YCM conflicts with UltiSnips TAB key usage
" https://github.com/Valloric/YouCompleteMe/blob/master/doc/youcompleteme.txt

" let g:UltiSnipsExpandTrigger="<s-space>"
" let g:UltiSnipsJumpForwardTrigger="<s-space>"
" let g:UltiSnipsJumpBackwardTrigger="<c-s-space>"

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

" showmarks
" let g:showmarks_enable = 0
" let g:showmarks_ignore_type="hqpr"
" let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

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
" CtrlP
if has_key(g:plugs, 'ctrlp.vim')
  " https://github.com/kien/ctrlp.vim
  let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn|cache)$',
      \ 'file': '\v\.(exe|so|dll|tgz|tar|zip|log)$',
      \ }
  " r:  the nearest ancestor that contains one of these directories or files: .git  .hg .svn .bzr _darcs
  " a: like c, but only if the current working directory outside of CtrlP is not a direct ancestor of the directory of the current file.
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
  " Max open 2 windows, vertical split, jump to first opened file, open in
  " current window
  let g:ctrlp_open_multiple_files = '2vjr'

  " Quickly open the command-line CtrlP plugin.
  " nnoremap <leader>q :CtrlPCmdline<CR>
  " nnoremap <leader>t :CtrlPTag<cr>
  " nnoremap <leader>p :CtrlP<cr>
  " nnoremap <leader>b :CtrlPBuffer<cr>

  " From http://robots.thoughtbot.com/faster-grepping-in-vim
  if executable('ag')
    " http://blog.patspam.com/2014/super-fast-ctrlp
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup
          \ --ignore .git
          \ --ignore .svn
          \ --ignore .hg
          \ --ignore .DS_Store
          \ --ignore "**/*.pyc"
          \ -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabular
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
if has_key(g:plugs, 'YouCompleteMe')
  let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
  let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
  let g:ycm_min_num_of_chars_for_completion = 3
  let g:ycm_use_ultisnips_completer = 1
  " let g:ycm_add_preview_to_completeopt = 1 " Allready set in completeopt
  let g:ycm_autoclose_preview_windor_after_completion = 1
  let g:ycm_autoclose_preview_window_after_insertion = 0
  let g:ycm_collect_identifiers_from_comments_and_strings = 0
  let g:ycm_collect_identifiers_from_tags_files = 1
  let g:ycm_seed_identifiers_with_syntax = 1
  let g:ycm_complete_in_comments = 1
  let g:ycm_complete_in_strings = 1
  let g:ycm_auto_trigger = 1
  let g:ycm_semantic_triggers =  {
    \   'php,php.symfony,php.drupal' : ['->', '::'],
    \   'cs,java,javascript,d,python,perl6,scala,vb,elixir,go' : ['.'],
    \   'vim' : ['re![_a-zA-Z]+[_\w]*\.'],
    \ }
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vdebug
" Check local docker0 interface if Vdebug can't connect: ip addr show docker0
let g:vdebug_keymap =  {"run": "<F11>"}
let g:vdebug_options = {"path_maps": {"/srv/udvikling/": "/home/hfa/remote_mounts/dev/"}, "break_on_open": 0, "watch_window_style": "compact", "port": 9000}
let g:vdebug_features = { 'max_children': 128 }
" let g:vdebug_options["debug_file_level"] = 2
" let g:vdebug_options["debug_file"] = "/tmp/vdebug.log"

"let g:vdebug_features = { 'max_depth': 2048, 'max_children': 128 }

" SuperTab
let g:SuperTabDefaultCompletionType = '<C-n>'

" Tern for vim
let g:tern#command = ['tern'] " it is installed via npm, and the command is in PATH

" Gist vim
" let g:gist_detect_filetype = 1
" let g:gist_show_privates = 1
" let g:gist_get_multiplefile = 1

" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" Scratch
" nnoremap <Leader>s :Scratch<CR>

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

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Use Ack to search for word under cursor
" map <F9> <Esc>:exec("Ack --php ".expand("<cword>"))<CR>

let g:pdv_template_dir = $VIMHOME."/pdv_tpls"
" http://www.reddit.com/r/vim/comments/1nnngz/issue_with_pdv/
" nnoremap <buffer> <Leader>d :call pdv#DocumentWithSnip()<CR>
nnoremap <Leader>d :call pdv#DocumentWithSnip()<CR>
nnoremap <Leader>rd :call RemoveDocBlock()<CR>

" Easy motion
" map <Leader> <Plug>(easymotion-prefix)

" Vim-php-cs-fixer
" - Integration for https://github.com/fabpot/PHP-CS-Fixer
" Level:
" - psr0
" - psr1
" - psr2
" - symfony
" let g:php_cs_fixer_level = "all"                  " which level ?
" Config:
" - default: A default configuration
" - magento: The configuration for a Magento application
" - sf23   : The configuration for the Symfony 2.3+ branch
" let g:php_cs_fixer_config = "default"             " configuration
" let g:php_cs_fixer_php_path = "php"               " Path to PHP
" Fixers:
" let g:php_cs_fixer_fixers_list = "linefeed,short_tag,indentation"
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd / <leader>pcf)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 1                    " Return the output of command if 1, else an inline information.
" Default mappings <leader>pcf fix file / <leader>pcd fix directory

" JSON
" Don't hide "
let g:vim_json_syntax_conceal = 0

" Indentguides
" <Leader>ig
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
nnoremap <silent> <Leader>ig <Plug>IndentGuidesToggle
" let g:indent_guides_guide_size = 1
" }}}

" let g:deoplete#enable_at_startup = 1
" let g:deoplete#omni_patterns = {}
" let g:deoplete#omni_patterns.php = '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'"

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neomake
" if has_key(g:plugs, 'neomake')
"   let g:neomake_php_phpmd_args = ['%:p', 'text', '/home/hfa/.config/phpmd/phpmd_swat_rules.xml']
" endif

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
if has('nvim')
  set inccommand=split            " Incremental replace, https://github.com/neovim/neovim/pull/5561
endif
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
if !has('nvim')
  " Default in neovim
  set backspace=indent,eol,start    " allow backspacing over everything in insert mode
endif
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
if !has('nvim')
  " Indicates a fast terminal connection. More characters will be sent to the screen for redrawing
  set ttyfast
endif
" http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
set ttimeout
set ttimeoutlen=100
set timeoutlen=1000
" NeoVim handles ESC keys as alt+key set this to solve the problem
" https://github.com/neovim/neovim/issues/2051
if has('nvim')
  set ttimeoutlen=0
endif

" Do not autoread changed files, also see checktime augroup
set noautoread

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clipboard {{{
"
" In insert mode:
" - <C+r> *: Primary selection
" - <C+r> +: Contents of clipboard
"
" use X clipboard if avaliable
" let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'
" Make it work in Neovim
if (has('nvim') && has('clipboard') && executable('xsel') && exists('$DISPLAY'))
  set clipboard+=unnamedplus
elseif (has('nvim') && has('clipboard') && executable('pbcopy') && has('mac'))
  set clipboard+=unnamedplus
endif
" }}}

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

" if v:version >= 703
"     " tells Vim to create <FILENAME>.un~ files whenever you edit a file. These files contain undo information so you can undo previous actions even after you close and reopen a file.
"     set undofile
"     set undodir=~/.vim/undo,~/tmp,/tmp
" endif

set keymodel=startsel             " Allow select of text in insert mode using shift

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlightning
"
if !has('nvim')
  " Defaults on Neovim
  syntax on                         " Enable syntax highlightning
  filetype plugin on                " Enable filetype settings
  filetype indent on
endif
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

" https://github.com/sanguis/drupal-snippets/blob/master/plugin/snipMate_drupal.vim
" Drupal filename function. Use instead of Filename().
function! DrupalFilename(...)
  " We need to chop off two path components. This has no adverse
  " effect on files with only one path component.
  let filename = expand('%:t:r:r')
  if filename == '' | return a:0 == 2 ? a:2 : '' | endif
  return !a:0 || a:1 == '' ? filename : substitute(a:1, '$1', filename, 'g')
endf

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

function! RemoveDocBlock()
  normal [/V]/x
endfunction

" Based on https://www.drupal.org/project/vimrc
let s:project_root_cache = {}
function! FindProjectRoot(markers)
  let s:slash = !exists("+shellslash") || &shellslash ? '/' : '\'
  let directory = expand('%:p:h')

  " If we have a cached answer, then return it.
  if has_key(s:project_root_cache, directory)
    return s:project_root_cache[directory]
  endif

  let path_components = split(directory, s:slash, 1)
  let project_root = remove(path_components, 0)

  for marker_list in values(a:markers)
    call map(marker_list, 'join(v:val, s:slash)')
  endfor

  for part in path_components
    let project_root .= s:slash . part

    for project_type in keys(a:markers)
        let project = get(a:markers,project_type,[])
        for marker in project
          let is_project_root = 1
          " Since globpath() is built in to vim, this should be fast.
          if globpath(project_root, marker) == ''
            let is_project_root = 0
            break
          endif
        endfor " marker

        " If all the markers are there, then this looks like a the project root.
        if is_project_root
          let s:project_root_cache[directory] = {'root': project_root, 'type': project_type}
          return s:project_root_cache[directory]
        endif
    endfor
  endfor " part

  return {}
endfunction

" Set options for Symfony Project
function! PHPProjectDetect(type)
  let markers = {'Symfony' : [
        \   ['app', 'Resources'],
        \ ],
        \ 'Drupal7' : [
        \   ['index.php'],
        \   ['update.php'],
        \   ['includes', 'bootstrap.inc'],
        \   ['modules', 'node', 'node.module'],
        \   ['modules', 'system', 'system.module'],
        \ ],
        \ 'Drupal8' : [
        \   ['index.php'],
        \   ['core', 'install.php'],
        \   ['core', 'includes', 'bootstrap.inc'],
        \   ['core', 'modules', 'node', 'node.module'],
        \   ['core', 'modules', 'system', 'system.module'],
        \ ], }

  let l:project = FindProjectRoot(markers)
  let l:filetype_suffix = ''

  if has_key(l:project, 'root')
    if l:project['type'] == 'Symfony'
      let l:filetype_suffix = 'symfony'
      let l:theme_path=l:project['root'].'/app/Resources/themes/**'
      execute 'set path+='.l:theme_path
    elseif l:project['type'] == 'Drupal7'
      let l:filetype_suffix = 'drupal'
    elseif l:project['type'] == 'Drupal8'
      let l:filetype_suffix = 'drupal'
    endif

    execute 'setlocal filetype=' . a:type . '.'. l:filetype_suffix
  endif
endfun

" Based on https://github.com/qbbr/vim-symfony/blob/master/plugin/sf2jmp2viewFromView.vim
" Jump to a twig in symfony
function! s:SfJumpToTwig()
  let linecontent = getline(line('.'))
  let matches = matchlist(linecontent, '\v\C([A-Z]{1}[a-z]{1,}Bundle):([^:]+)?:([^.:]+\.html\.twig)')

  if (empty(matches))
    echohl WarningMsg | echomsg "Pattern not found" | echohl None
    return
  endif

  try
    let filename = matches[1].'/'.matches[2].'/'.matches[3]
    execute ":find ".filename
  catch
    echohl WarningMsg | echomsg "Template file ". filename ." not found" | echohl None
  endtry
endfunction

command! SfJumpToTwig call s:SfJumpToTwig()

" Based on https://raw.githubusercontent.com/qbbr/vim-symfony/master/plugin/sf2jmp2controllerFromRouting.vim
function! s:Sf2jmp2controllerFromRouting()
    let linecontent = getline(line('.'))

    " @AcmeDemoBundle/Controller/DefaultController.php
    " 1 - str, 2 - namespace, 3 - bundle, 4 - controller
    let matches = matchlist(linecontent, '\v\C\@([A-Z]{1}[a-z]{1,})(\w+Bundle)/Controller/(\w+)Controller\.php')

    if (empty(matches))
        " _controller: AcmeDemoBundle:Welcome:index
        " 5 - action (not need)
        let matches = matchlist(linecontent, '\v\C_controller: \([A-Z]\{1,}[a-z]\{1,}\):\(\w\+\):\(\w\+\)')
    endif

    echo matches

    if (empty(matches))
        echohl WarningMsg | echomsg "controller not found" | echohl None
        return
    endif

    let filename = 'src/' . matches[1] . '/' . matches[2] . '/Controller/'. matches[3] . 'Controller.php'

    echo filename

    if filereadable(filename)
        edit filename
    else
        echohl WarningMsg | echomsg "could not open controller (path: " . filename . ")" | echohl None
    endif
endfunction

command! SfJumpToController call s:Sf2jmp2controllerFromRouting()

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keymaps
"
" yankstack overrides mappings
" call yankstack#setup()
source $VIMHOME/bindings.vim

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

augroup vimrc_phpproject
  autocmd!
  autocmd BufRead,BufNewFile *.php call PHPProjectDetect('php')
  autocmd BufRead,BufNewFile *.scss call PHPProjectDetect('scss')
  autocmd BufRead,BufNewFile *.yml call PHPProjectDetect('yaml')
  autocmd BufRead,BufNewFile *.module call PHPProjectDetect('php')
  autocmd BufRead,BufNewFile *.inc call PHPProjectDetect('php')
  autocmd BufRead,BufNewFile *.install call PHPProjectDetect('php')
  " Based on vimrc from http://www.shlomifish.org/open-source/projects/conf/vim/current/vimrc
  autocmd BufRead,BufNewFile *.ini.append.php set filetype=ezpini
  " http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
  " Don't repeat singleline comments
  autocmd FileType php,php.drupal,php.symfony set comments-=:// comments+=f:// comments+=sl:/*,mb:*,elx:*/
augroup END

augroup vimrc_drupal
  autocmd!
  autocmd FileType php.drupal let g:php_cs_fixer_level = "Drupal"
  autocmd FileType php.drupal let g:neomake_php_phpcs_args_standard = "Drupal"
  autocmd FileType php.drupal let g:neomake_drupal_phpcs_args_standard = "Drupal"
  autocmd FileType php.drupal let g:neomake_drupal_enabled_makers = ['php', 'phpcs', 'phpmd']
augroup END

augroup vimrc_symfony
  autocmd!
  autocmd FileType php.symfony let g:vdebug_options['path_maps'] = {"/var/www": "/home/enrique/Localdev/pompdelux/www"}
  autocmd FileType php.symfony let g:neomake_php_phpcs_args_standard = "Symfony2"
  autocmd FileType php.symfony let g:neomake_symfony_phpcs_args_standard = "Symfony2"
  autocmd FileType php.symfony let g:neomake_symfony_enabled_makers = ['php', 'phpcs', 'phpmd']
  autocmd FileType php.symfony let g:php_cs_fixer_level = "symfony"
  autocmd FileType php.symfony let g:php_cs_fixer_config = "sf23"
  autocmd FileType php.symfony setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufEnter *Controller.php nmap <buffer><leader>g :SfJumpToTwig<CR>
  autocmd BufEnter routing.yml nmap <buffer><leader>g :SfJumpToController<CR>
augroup END

" Reads the skeleton files, delete empty line
if !&diff
  augroup vimrc_skeleton
    autocmd!
"    autocmd BufNewFile *.php 0r $VIMHOME/skel/php |normal Gdd2h
    autocmd BufNewFile *.module 0r $VIMHOME/skel/drupal_module |normal Gdd2h
    autocmd BufNewFile *.info 0r $VIMHOME/skel/drupal_info |normal Gdd2h
    autocmd BufNewFile *.html 0r $VIMHOME/skel/html | $,$d
"    autocmd BufNewFile *.html setlocal ft=xhtml
    autocmd BufNewFile *.css 0r $VIMHOME/skel/css | $,$d
    autocmd BufNewFile *.sh 0r $VIMHOME/skel/bash | $,$d
    autocmd BufNewFile .tern-project 0r $VIMHOME/skel/tern-project | $,$d
    autocmd BufNewFile Dockerfile 0r $VIMHOME/skel/Dockerfile | $,$d
    autocmd BufNewFile .dockerignore 0r $VIMHOME/skel/dockerignore | $,$d
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

augroup vimrc_twig
    autocmd!
    autocmd BufNewFile,BufRead *.html.twig,*.twig setlocal filetype=html.twig
    " TODO: check if symfony project:
    autocmd FileType html.twig setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
augroup END

" Use "json" to format .json
" https://github.com/trentm/json
augroup vimrc_json
    autocmd!
    autocmd FileType json setlocal equalprg=json
augroup END

" ansible-vim does not detect playbooks
augroup vimrc_ansible
    autocmd!
    autocmd BufRead,BufNewFile ~/Dev/ansible/*.yml set ft=ansible
    autocmd BufRead,BufNewFile inventory set ft=ansible_hosts
augroup END

" Jenkinsfile
augroup vimrc_jenkins
  autocmd!
  autocmd BufNewFile,BufRead Jenkinsfile setlocal filetype=groovy
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

" Resize splits when the window is resized
augroup vimrc_resize
  autocmd!
  autocmd VimResized * :wincmd =
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

" Help Neovim check if file has changed on disc
" https://github.com/neovim/neovim/issues/2127
augroup checktime
    autocmd!
    if !has("gui_running")
        "silent! necessary otherwise throws errors when using command
        "line window.
        autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * checktime
    endif
augroup END

if has_key(g:plugs, 'neomake')
  " let g:neomake_verbose = 2
  " let g:neomake_logfile = '/tmp/neomake.log'
  " Disable phpcs by default
  let g:neomake_php_enabled_makers = ['php', 'phpmd']
  let g:neomake_javascript_enabled_makers = ['jshint']
  let g:neomake_open_list=2
  let g:neomake_list_height=5
  " autocmd! BufWritePost * Neomake
  if has('nvim')
    call neomake#configure#automake('nrw', 750)
  else
    call neomake#configure#automake('w')
  endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Async ctags test
if has('nvim')
 function! s:CtagsJobStart()
     let job_args = [&shell, '-c', 'git ctags']
     call jobstart(job_args, s:CtagsJobCallbacks)
 endfunction

 function! s:CtagsJobHandler(id, data, event)
   " Disable if stderr - not git project probably
   if a:event ==# "stderr"
   endif
 endfunction

 let s:CtagsJobCallbacks = {
       \ 'on_stdout': function('s:CtagsJobHandler'),
       \ 'on_stderr': function('s:CtagsJobHandler'),
       \ 'on_exit': function('s:CtagsJobHandler'),
       \ }

  augroup vimrc_ctags
    autocmd!
    autocmd BufWritePost *.php :call s:CtagsJobStart()
  augroup END
endif

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
" Utils functions
"
" Rename current file, based on https://github.com/martin-svk/dot-files/blob/master/neovim/autoload/utils.vim#L111
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    execute ':saveas ' . new_name
    execute ':silent !rm ' . old_name
    redraw!
  endif
endfunction
command! Rename :call RenameFile()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI settings
"
source $VIMHOME/ui.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn off any existing search
" Handled by incsearch plugin
" au VimEnter * nohls
