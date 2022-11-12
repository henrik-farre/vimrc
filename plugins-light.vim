""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
" https://github.com/junegunn/vim-plug/wiki/faq
"
if empty(glob("$VIMHOME/autoload/plug.vim"))
  silent !curl -fLo $VIMHOME/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

silent! call plug#begin("$VIMHOME/bundle")
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git
" Shows git branch in statusline + tags to the one in .git/tags if exists
Plug 'tpope/vim-fugitive'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion using CMP
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-emoji'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Code formatting
" Auto complete quotes, parenthesis, brackets and so on
" Plug 'Raimondi/delimitMate'
Plug 'windwp/nvim-autopairs'
Plug 'andymass/vim-matchup'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
" EOL plugin, replaced by builtin
" Plug 'haya14busa/incsearch.vim'
" Highlights on f F t T
" Plug 'bradford-smith94/quick-scope'
" Plug 'ggandor/lightspeed.nvim'
Plug 'godlygeek/tabular'
" Included in neovim 0.8
" Plug 'lewis6991/spellsitter.nvim'
" Detect tabs vs spaces
Plug 'tpope/vim-sleuth'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorschemes / UI
Plug 'pacha/vem-dark'
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'nvim-lualine/lualine.nvim'
" Icons for filetypes
Plug 'ryanoasis/vim-devicons'
" Icons for filetypes - support for trouble and more
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'norcalli/nvim-colorizer.lua'
" Show indent lines
Plug 'lukas-reineke/indent-blankline.nvim'
" Add visual marks in gutter
Plug 'kshenoy/vim-signature'
" causes all trailing whitespace characters to be highlighted.
Plug 'ntpeters/vim-better-whitespace'
" Highlight TODO/FIXME and more
Plug 'folke/todo-comments.nvim'
" vim.ui handling
Plug 'stevearc/dressing.nvim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Registers
" Show registers
Plug 'junegunn/vim-peekaboo'
" Improve cut/paste
Plug 'svermeulen/vim-easyclip'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
" Examples of python interpolation:
" https://medium.com/brigade-engineering/sharpen-your-vim-with-snippets-767b693886db
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP setup
Plug 'neovim/nvim-lspconfig'
Plug 'folke/lsp-colors.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'ahmedkhalf/project.nvim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fuzzy finders
" FZF, first repository contains plugin, the other commands and mappings
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()
