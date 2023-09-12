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
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Debugging
Plug 'puremourning/vimspector'
" Plug 'mfussenegger/nvim-dap'
" Plug 'mfussenegger/nvim-dap-python'
" Plug 'rcarriga/nvim-dap-ui'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git
" Shows git branch in statusline + tags to the one in .git/tags if exists
Plug 'tpope/vim-fugitive'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Web
Plug 'mattn/emmet-vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion using CMP
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-path'
Plug 'FelipeLema/cmp-async-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-emoji'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'petertriho/cmp-git'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Code formatting
" Auto complete quotes, parenthesis, brackets and so on
" Plug 'Raimondi/delimitMate'
Plug 'windwp/nvim-autopairs'
" Generate doc strings
Plug 'danymat/neogen'
Plug 'sbdchd/neoformat'
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
" vim tests
Plug 'junegunn/vader.vim'

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
" Plug 'kevinhwang91/nvim-bqf'
" Jump with s<char1><char2>
Plug 'ggandor/leap.nvim'
" File explorer
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim', { 'branch': 'v3.x'}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Registers
" Show registers
" - disabled for now as it breaks mapping <C-r> to <C-r><C-o>
" Plug 'junegunn/vim-peekaboo'
" Improve cut/paste
Plug 'svermeulen/vim-easyclip'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
" Examples of python interpolation:
" https://medium.com/brigade-engineering/sharpen-your-vim-with-snippets-767b693886db
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetypes
" Ansible
Plug 'pearofducks/ansible-vim'
" Kubernetes + snippets
Plug 'andrewstuart/vim-kubernetes'
" Hashicorp plugins
Plug 'hashivim/vim-terraform'
" Syntax and more for tmux
Plug 'tmux-plugins/vim-tmux'
" TypeScript
Plug 'leafgarland/typescript-vim'
" vim syntax for helm templates (yaml + gotmpl + sprig + custom)
Plug 'towolf/vim-helm'
" JavaScript bundle for vim, this bundle provides syntax and indent plugins.
" Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" Go
" Plug 'fatih/vim-go'
" Markdown
Plug 'tpope/vim-markdown', { 'for': 'ghmarkdown' }
" Add-on to Tim Pope's markdown.vim to highlight using Github Flavored Markdown.
Plug 'jtratner/vim-flavored-markdown', { 'for': 'ghmarkdown' }
" Yaml, use :YAMLView Shows the full path and value of the current key/value pair
Plug 'cuducos/yaml.nvim', { 'for': 'yaml' }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LSP setup
Plug 'neovim/nvim-lspconfig'
" Plug 'iamcco/diagnostic-languageserver'
Plug 'folke/lsp-colors.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'folke/trouble.nvim'
" Show 💡 if there is a code action avaliable
Plug 'kosayoda/nvim-lightbulb'
" Set working to project directory
"Plug 'airblade/vim-rooter'
Plug 'ahmedkhalf/project.nvim'
Plug 'someone-stole-my-name/yaml-companion.nvim'
" Show function signature when you type
Plug 'ray-x/lsp_signature.nvim'
" Linting and formatting
Plug 'nvim-lua/plenary.nvim' " required by several plugins like null-ls
Plug 'jose-elias-alvarez/null-ls.nvim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fuzzy finders
" FZF, first repository contains plugin, the other commands and mappings
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Telescope and dependencies
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'nvim-telescope/telescope.nvim'
call plug#end()
