return {
------------------------------------------------------------
-- Treesitter
--
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    "andymass/vim-matchup", -- match-up is a plugin that lets you highlight, navigate, and operate on sets of matching text.
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { "dockerfile", "yaml", "python", "bash", "json", "javascript", "html", "css", "lua", "markdown", "toml", "hcl"},
      highlight = {
        enable = true,
      },
      indent = {
        enable = false,
      },
      incremental_selection = {
        enable = true,
      },
      -- https://github.com/andymass/vim-matchup
      matchup = {
        enable = true
      },
    }
  end,
},

------------------------------------------------------------
-- Debugging
--
{
  "puremourning/vimspector",
  keys = {
    { "<leader><F5>", "<Plug>VimspectorContinue", desc = "VimspectorContinue" },
    { "<leader><F3>", "<Plug>VimspectorStop", desc = "VimspectorStop" },
    { "<leader><F4>", "<Plug>VimspectorRestart", desc = "VimspectorRestart" },
    { "<leader><F6>", "<Plug>VimspectorPause", desc = "VimspectorPause" },
    { "<leader><F8>", "<Plug>VimspectorAddFunctionBreakpoint", desc = "VimspectorAddFunctionBreakpoint" },
    { "<F9>", "<Plug>VimspectorToggleBreakpoint", desc = "VimspectorToggleBreakpoint" },
    { "<F10>", "<Plug>VimspectorStepOver", desc = "VimspectorStepOver" },
    { "<F11>", "<Plug>VimspectorStepInto", desc = "VimspectorStepInto" },
    { "<F12>", "<Plug>VimspectorStepOut", desc = "VimspectorStepOut" },
  }
},
-- # 'mfussenegger/nvim-dap'
-- # 'mfussenegger/nvim-dap-python'
-- # 'rcarriga/nvim-dap-ui'

------------------------------------------------------------
-- Git
--
"tpope/vim-fugitive", -- Shows git branch in statusline + tags to the one in .git/tags if exists

------------------------------------------------------------
-- HTML
--
{
  -- Completes html tags, e.g. div>h1
  "mattn/emmet-vim",
  init = function()
    vim.g.user_emmet_expandabbr_key = '<c-e>'
    vim.g.user_emmet_complete_tag = 1
  end
},

------------------------------------------------------------
-- Completion
--

------------------------------------------------------------
-- Code formatting
--
{
  -- Auto complete quotes, parenthesis, brackets and so on
  "windwp/nvim-autopairs",
  config = function()
    require("nvim-autopairs").setup {}
  end
},

-- # 'Raimondi/delimitMate'

{
  -- Generate doc strings
  "danymat/neogen",
  config = function()
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
  end,
},
"sbdchd/neoformat",
{
  "preservim/nerdcommenter",
  keys = {
    { "<F5>", "<Plug>NERDCommenterToggle<CR>", desc = "NERDCommenter" }
  },
  init = function()
    vim.g.NERDCreateDefaultMappings = 0
    -- Add spaces after comment delimiters by default
    vim.g.NERDSpaceDelims = 1
    vim.g.NERDDefaultAlign = 'left'
  end
},
"tpope/vim-surround",
"godlygeek/tabular",

------------------------------------------------------------
-- Misc plugins
--
-- # 'haya14busa/incsearch.vim' -- EOL plugin, replaced by builtin
-- # 'bradford-smith94/quick-scope' -- Highlights on f F t T
-- # 'ggandor/lightspeed.nvim'
-- # 'lewis6991/spellsitter.nvim' -- Included in neovim 0.8
"tpope/vim-sleuth", -- Detect tabs vs spaces
-- # "junegunn/vader.vim", -- vim tests

------------------------------------------------------------
-- Colorschemes / UI
--
"pacha/vem-dark",
"nvim-lualine/lualine.nvim",
{
  -- Icons for filetypes, used by telescope, trouble and more
  "nvim-tree/nvim-web-devicons",
  -- fix zshrc
  config = function()
    require('nvim-web-devicons').setup {
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
},
-- # 'norcalli/nvim-colorizer.lua'
{
  -- Show indent lines
  "lukas-reineke/indent-blankline.nvim",
  tag = 'v2.20.8',
  config =  function()
    require("indent_blankline").setup {
      char_list = {'│', '¦', '┆', '┊'},
      filetype_exclude = {"help", "terminal", "list", "nofile", "man"},
      buftype_exclude = {"help", "terminal", "list", "nofile", "man"},
      bufname_exclude = {"man://.*"},
      show_current_context = true,
    }
  end
},
"kshenoy/vim-signature", -- Add visual marks in gutter
"ntpeters/vim-better-whitespace", -- causes all trailing whitespace characters to be highlighted.
{
  -- Highlight TODO/FIXME and more
  "folke/todo-comments.nvim",
  config = function()
    require("todo-comments").setup{}
  end
},
{
  -- Handle vim.ui elements (Used by yaml-companion)
  "stevearc/dressing.nvim",
  config = function()
    require('dressing').setup{}
  end
},
------------------------------------------------------------
-- Registers
--
-- Show registers
-- # 'junegunn/vim-peekaboo' -- disabled for now as it breaks mapping <C-r> to <C-r><C-o>
-- # Increase size of window
-- # vim.g.peekaboo_window = "vert bo 70new"
{
  -- Improve cut/paste
  "svermeulen/vim-easyclip",
  keys = {
    { 'x', '"+x', mode = { 'n', 'x' }, desc = 'Easyclip Cut' },
  },
  init = function()
    vim.g.EasyClipAlwaysMoveCursorToEndOfPaste = 1
    vim.g.EasyClipPreserveCursorPositionAfterYank = 1
    vim.g.EasyClipUseCutDefaults = 0
  end
},

------------------------------------------------------------
-- Snippets
--
{
  -- Examples of python interpolation:
  -- https://medium.com/brigade-engineering/sharpen-your-vim-with-snippets-767b693886db
  "SirVer/ultisnips",
  init = function()
    vim.g.snips_author = 'Henrik Farre <henrik@rockhopper.dk>'
    vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
    vim.g.UltiSnipsJumpBackwardTrigger = "<s-tab>"
  end,
  dependencies = {
    "honza/vim-snippets",
  }
},

------------------------------------------------------------
-- Filetypes
--
{
  -- Ansible
  "pearofducks/ansible-vim",
  init = function()
    -- When this variable is set, indentation will completely reset (unindent to column 0) after two newlines in insert-mode. The normal behavior of YAML is to always keep the previous indentation, even across multiple newlines with no content.
    vim.g.ansible_unindent_after_newline = 0
    vim.g.ansible_ftdetect_filename_regex = [[\v(playbook|site|local|requirements)\.ya?ml$]]
  end
},
"andrewstuart/vim-kubernetes", -- Kubernetes + snippets
{
  -- Hashicorp plugins
  "hashivim/vim-terraform",
  init = function()
    vim.g.terraform_fmt_on_save = 0        -- Run terraform fmt on save to comply with style guide
    vim.g.terraform_align = 1              -- Set indent to 2 spaces
  end
},
"tmux-plugins/vim-tmux", -- Syntax and more for tmux
"leafgarland/typescript-vim", -- TypeScript
"towolf/vim-helm", -- vim syntax for helm templates (yaml + gotmpl + sprig + custom)
-- # 'pangloss/vim-javascript', { 'for': 'javascript' } JavaScript bundle for vim, this bundle provides syntax and indent plugins.
-- # 'fatih/vim-go'
{
  -- Github flavored Markdown
  "tpope/vim-markdown",
  ft = "ghmarkdown",
  dependencies = {
    {
      -- Add-on to Tim Pope"s markdown.vim to highlight using Github Flavored Markdown.
      "jtratner/vim-flavored-markdown",
      ft = "ghmarkdown"
    },
  }
},
{
  -- Yaml, use :YAMLView Shows the full path and value of the current key/value pair
  -- fork that hardcodes yaml and does not change ft
  "henrik-farre/yaml.nvim",
  branch = "hack_to_work_with_other_ft",
  config = function()
    require("yaml_nvim").setup({ ft = { "yaml", "helm", "yaml.ansible" } })
  end
},
{
  "someone-stole-my-name/yaml-companion.nvim",
  keys = {
    { "<leader>y", function() require("yaml-companion").open_ui_select() end, desc = "YAML companion UI open" }
  }
},
{
  -- Preview markdown
  "iamcco/markdown-preview.nvim",
  build = "cd app && npx --yes yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown", "ghmarkdown" }
  end
},
------------------------------------------------------------
-- LSP setup
--
{
  -- LSP colors, highlightning of messages for colorschemes that does not support
  -- those groups
  "folke/lsp-colors.nvim",
  config = function()
    require("lsp-colors").setup({
      Error = "#db4b4b",
      Warning = "#e0af68",
      Information = "#0db9d7",
      Hint = "#10B981"
    })
  end,
},
-- 'iamcco/diagnostic-languageserver'
{
  -- Trouble, A pretty list for showing diagnostics, references, telescope
  -- results, quickfix and location lists to help you solve all the trouble your
  -- code is causing.
  "folke/trouble.nvim",
  config = function()
    require("trouble").setup({
      height = 5,
      padding = false,
      mode = "document_diagnostics",
      auto_open = true,
      auto_close = false,
      use_diagnostic_signs = true
    })
  end,
},
-- # 'kosayoda/nvim-lightbulb' -- Show 💡 if there is a code action avaliable
-- Show function signature when you type
{
  "ray-x/lsp_signature.nvim",
  config = function()
    require("lsp_signature").setup {}
  end,
},
"nvim-lua/plenary.nvim", -- required by several plugins like null-ls
{
  -- Linting and formatting
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    require("null-ls").setup({
      root_dir = require('null-ls.utils').root_pattern(".null-ls-root", "Makefile", ".git", ".flake8", "pyproject.toml"),
      sources = {
        require("null-ls").builtins.diagnostics.flake8,
        -- require("null-ls").builtins.diagnostics.mypy,
      },
    })
  end,
},

------------------------------------------------------------
-- Navigation / Fuzzy finders
--
-- # 'airblade/vim-rooter'
{
  -- Set working to project directory
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup{
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pyproject.toml" },
      -- silent_chdir = false,
      ignore_lsp = { "null-ls" },
    }
  end,
},
{
  -- Jump with s<char1><char2>
  "ggandor/leap.nvim",
  config = function()
    require('leap').add_default_mappings()
  end
},
{
  -- fzf.vim repository contains plugin, the other commands and mappings
  "junegunn/fzf.vim",
  dependencies = { "junegunn/fzf" },
  cond = vim.fn.executable('fzf') == 1,
  config = function()
    vim.env.FZF_DEFAULT_OPTS = '--keep-right -x --inline-info'
  end,
  keys = {
    { "<leader>bv", ":Buffers<cr>" }
  }
},

}
