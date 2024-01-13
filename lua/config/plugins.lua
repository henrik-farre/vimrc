------------------------------------------------------------
-- Load Plugins using vim-plug
-- https://github.com/junegunn/vim-plug/wiki/faq
-- https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom
--
local Plug = vim.fn['plug#']

vim.call('plug#begin', "$VIMHOME/bundle")

------------------------------------------------------------
-- Treesitter
Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn[':TSUpdate']})

------------------------------------------------------------
-- Debugging
Plug('puremourning/vimspector')
-- Plug 'mfussenegger/nvim-dap'
-- Plug 'mfussenegger/nvim-dap-python'
-- Plug 'rcarriga/nvim-dap-ui'

------------------------------------------------------------
-- Git
-- Shows git branch in statusline + tags to the one in .git/tags if exists
Plug('tpope/vim-fugitive')

------------------------------------------------------------
-- General Web
Plug('mattn/emmet-vim')

------------------------------------------------------------
-- Completion using CMP
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-nvim-lua')
Plug('hrsh7th/cmp-nvim-lsp')
-- Plug 'hrsh7th/cmp-path'
Plug('FelipeLema/cmp-async-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/cmp-emoji')
Plug('quangnguyen30192/cmp-nvim-ultisnips')
Plug('petertriho/cmp-git')

------------------------------------------------------------
-- Code formatting
-- Auto complete quotes, parenthesis, brackets and so on
-- Plug 'Raimondi/delimitMate'
Plug('windwp/nvim-autopairs')
-- Generate doc strings
Plug('danymat/neogen')
Plug('sbdchd/neoformat')
Plug('andymass/vim-matchup')
Plug('preservim/nerdcommenter')
Plug('tpope/vim-surround')

------------------------------------------------------------
-- Misc
-- EOL plugin, replaced by builtin
-- Plug 'haya14busa/incsearch.vim'
-- Highlights on f F t T
-- Plug 'bradford-smith94/quick-scope'
-- Plug 'ggandor/lightspeed.nvim'
Plug('godlygeek/tabular')
-- Included in neovim 0.8
-- Plug 'lewis6991/spellsitter.nvim'
-- Detect tabs vs spaces
Plug('tpope/vim-sleuth')
-- vim tests
Plug('junegunn/vader.vim')

------------------------------------------------------------
-- Colorschemes / UI
Plug('pacha/vem-dark')
Plug('nvim-lualine/lualine.nvim')
-- Icons for filetypes
Plug('kyazdani42/nvim-web-devicons')
-- Plug 'norcalli/nvim-colorizer.lua'
-- Show indent lines
Plug('lukas-reineke/indent-blankline.nvim', { tag = 'v2.20.8' })
-- Add visual marks in gutter
Plug('kshenoy/vim-signature')
-- causes all trailing whitespace characters to be highlighted.
Plug('ntpeters/vim-better-whitespace')
-- Highlight TODO/FIXME and more
Plug('folke/todo-comments.nvim')
-- vim.ui handling
Plug('stevearc/dressing.nvim')
-- Plug 'kevinhwang91/nvim-bqf'
-- Jump with s<char1><char2>
Plug('ggandor/leap.nvim')
-- File explorer
Plug('MunifTanjim/nui.nvim')
Plug('nvim-neo-tree/neo-tree.nvim', { branch = 'v3.x' })
------------------------------------------------------------
-- Registers
-- Show registers
-- - disabled for now as it breaks mapping <C-r> to <C-r><C-o>
-- Plug 'junegunn/vim-peekaboo'
-- Improve cut/paste
Plug('svermeulen/vim-easyclip')

------------------------------------------------------------
-- Snippets
-- Examples of python interpolation:
-- https://medium.com/brigade-engineering/sharpen-your-vim-with-snippets-767b693886db
Plug('SirVer/ultisnips')
Plug('honza/vim-snippets')

------------------------------------------------------------
-- Filetypes
-- Ansible
Plug('pearofducks/ansible-vim')
-- Kubernetes + snippets
Plug('andrewstuart/vim-kubernetes')
-- Hashicorp plugins
Plug('hashivim/vim-terraform')
-- Syntax and more for tmux
Plug('tmux-plugins/vim-tmux')
-- TypeScript
Plug('leafgarland/typescript-vim')
-- vim syntax for helm templates (yaml + gotmpl + sprig + custom)
Plug('towolf/vim-helm')
-- JavaScript bundle for vim, this bundle provides syntax and indent plugins.
-- Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
-- Go
-- Plug 'fatih/vim-go'
-- Markdown
Plug('tpope/vim-markdown', { ['for'] = 'ghmarkdown' })
-- Add-on to Tim Pope's markdown.vim to highlight using Github Flavored Markdown.
Plug('jtratner/vim-flavored-markdown', { ['for'] = 'ghmarkdown' })
-- Yaml, use :YAMLView Shows the full path and value of the current key/value pair
-- - fork that hardcodes yaml and does not change ft
Plug('henrik-farre/yaml.nvim', { branch = 'hack_to_work_with_other_ft' })
-- Preview markdown
Plug('iamcco/markdown-preview.nvim', { ['do'] = vim.fn['cd app && npx --yes yarn install'] })
------------------------------------------------------------
-- LSP setup
Plug('neovim/nvim-lspconfig')
-- Plug 'iamcco/diagnostic-languageserver'
Plug('folke/lsp-colors.nvim')
Plug('onsails/lspkind-nvim')
Plug('folke/trouble.nvim')
-- Show 💡 if there is a code action avaliable
-- Plug 'kosayoda/nvim-lightbulb'
-- Set working to project directory
--Plug 'airblade/vim-rooter'
Plug('ahmedkhalf/project.nvim')
Plug('someone-stole-my-name/yaml-companion.nvim')
-- Show function signature when you type
Plug('ray-x/lsp_signature.nvim')
-- Linting and formatting
Plug('nvim-lua/plenary.nvim') -- required by several plugins like null-ls
Plug('jose-elias-alvarez/null-ls.nvim')

------------------------------------------------------------
-- Fuzzy finders
-- FZF, first repository contains plugin, the other commands and mappings
Plug('junegunn/fzf')
Plug('junegunn/fzf.vim')
-- Telescope and dependencies
-- Plug 'nvim-lua/popup.nvim'
-- Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
-- Plug 'nvim-telescope/telescope.nvim'

vim.call('plug#end')

------------------------------------------------------------
-- Plugin settings
--

------------------------------------------------------------
-- FZF
--
if vim.g.plugs['fzf'] and vim.fn.executable('fzf') == 1 then
  -- Override env from shell where I prefer -e
  vim.env.FZF_DEFAULT_OPTS = '--keep-right -x --inline-info'
end

------------------------------------------------------------
-- UltiSnips
--
vim.g.snips_author = 'Henrik Farre <henrik@rockhopper.dk>'
vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"

------------------------------------------------------------
-- Disable plugins:
--
vim.g.loaded_html_danish = 1       -- html_da
vim.g.loaded_netrwPlugin = 1       -- netrw
vim.g.loaded_vimballPlugin = 1     -- vimball
vim.g.loaded_matchparen = 1        -- Parenthesis matching is just too slow
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_matchit = 1

------------------------------------------------------------
-- Emmet
--
vim.g.user_emmet_expandabbr_key = '<c-e>'
vim.g.user_emmet_complete_tag = 1

------------------------------------------------------------
-- NERD Commenter
--
vim.g.NERDCreateDefaultMappings = 0
-- Add spaces after comment delimiters by default
vim.g.NERDSpaceDelims = 1
vim.g.NERDDefaultAlign = 'left'

------------------------------------------------------------
-- Ansible settings
-- When this variable is set, indentation will completely reset (unindent to column 0) after two newlines in insert-mode. The normal behavior of YAML is to always keep the previous indentation, even across multiple newlines with no content.
vim.g.ansible_unindent_after_newline = 0
vim.g.ansible_ftdetect_filename_regex = [[\v(playbook|site|local|requirements)\.ya?ml$]]

------------------------------------------------------------
-- Terraform settings
--
vim.g.terraform_fmt_on_save = 0        -- Run terraform fmt on save to comply with style guide
vim.g.terraform_align = 1              -- Set indent to 2 spaces

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

-- Auto complete pairs
if vim.g.plugs['nvim-autopairs'] then
  require("nvim-autopairs").setup {}
end

if vim.g.plugs['nvim-bqf'] then
  require('bqf').setup {}
end

if vim.g.plugs['leap.nvim'] then
  require('leap').add_default_mappings()
end

------------------------------------------------------------
-- Peekaboo
--
-- Increase size of window
if vim.g.plugs['vim-peekaboo'] then
  vim.g.peekaboo_window = "vert bo 70new"
end

------------------------------------------------------------
-- Easy clip
--
if vim.g.plugs['vim-easyclip'] then
  vim.g.EasyClipAlwaysMoveCursorToEndOfPaste = 1
  vim.g.EasyClipPreserveCursorPositionAfterYank = 1
  vim.g.EasyClipUseCutDefaults = 0
end

if vim.g.plugs['markdown-preview.nvim'] then
  vim.g.mkdp_filetypes = { "markdown", "ghmarkdown" }
end

------------------------------------------------------------
-- Indent Blankline
--
if vim.g.plugs['indent-blankline.nvim'] then
  require("indent_blankline").setup {
    char_list = {'│', '¦', '┆', '┊'},
    filetype_exclude = {"help", "terminal", "list", "nofile", "man"},
    buftype_exclude = {"help", "terminal", "list", "nofile", "man"},
    bufname_exclude = {"man://.*"},
    show_current_context = true,
  }
end

------------------------------------------------------------
-- Project
--
if vim.g.plugs['project.nvim'] then
  require("project_nvim").setup{
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pyproject.toml" },
    -- silent_chdir = false,
    ignore_lsp = { "null-ls" },
  }
end

------------------------------------------------------------
-- Highlight TODO/FIXME
--
if vim.g.plugs['todo-comments.nvim'] then
  require("todo-comments").setup{}
end

------------------------------------------------------------
-- Handle vim.ui elements (Used by yaml-companion)
--
if vim.g.plugs['dressing.nvim'] then
  require('dressing').setup{}
end

if vim.g.plugs['neo-tree.nvim'] then
  require('neo-tree').setup{
    default_component_configs = {
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
    },
    filesystem = {
      bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
      cwd_target = {
        sidebar = "tab",   -- sidebar is when position = left or right
        current = "window" -- current is when position = current
      },
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every
        --              -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    buffers = {
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --              -- the current file is changed while the tree is open.
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
      }
    }
  }
end

if vim.g.plugs['nvim-lightbulb'] then
  require("nvim-lightbulb").setup({
    autocmd = { enabled = true }
  })
end

if vim.g.plugs['yaml.nvim'] then
  require("yaml_nvim").setup({ ft = { "yaml", "helm", "yaml.ansible" } })
end

if vim.g.plugs['nvim-colorizer.lua'] then
  -- Colorizer setup - requires termguicolors
  require('colorizer').setup()
end
