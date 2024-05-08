return {
  ------------------------------------------------------------
  -- Treesitter
  --
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    dependencies = {
      "andymass/vim-matchup", -- match-up is a plugin that lets you highlight, navigate, and operate on sets of matching text.
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { "dockerfile", "yaml", "python", "bash", "json", "javascript", "html", "css", "lua", "markdown", "markdown_inline", "toml", "hcl", "vim", "terraform", "go" },
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
          disable = { 'yaml' }
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
    ft = "python",
    keys = {
      { "<leader><F5>", "<Plug>VimspectorContinue",              desc = "VimspectorContinue" },
      { "<leader><F3>", "<Plug>VimspectorStop",                  desc = "VimspectorStop" },
      { "<leader><F4>", "<Plug>VimspectorRestart",               desc = "VimspectorRestart" },
      { "<leader><F6>", "<Plug>VimspectorPause",                 desc = "VimspectorPause" },
      { "<leader><F8>", "<Plug>VimspectorAddFunctionBreakpoint", desc = "VimspectorAddFunctionBreakpoint" },
      { "<F9>",         "<Plug>VimspectorToggleBreakpoint",      desc = "VimspectorToggleBreakpoint" },
      { "<F10>",        "<Plug>VimspectorStepOver",              desc = "VimspectorStepOver" },
      { "<F11>",        "<Plug>VimspectorStepInto",              desc = "VimspectorStepInto" },
      { "<F12>",        "<Plug>VimspectorStepOut",               desc = "VimspectorStepOut" },
    }
  },
  -- # 'mfussenegger/nvim-dap'
  -- # 'mfussenegger/nvim-dap-python'
  -- # 'rcarriga/nvim-dap-ui'

  ------------------------------------------------------------
  -- HTML
  --
  {
    -- Completes html tags, e.g. div>h1
    "mattn/emmet-vim",
    ft = { 'html', 'css' },
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
    config = true
  },

  -- # 'Raimondi/delimitMate'

  {
    -- Generate doc strings
    "danymat/neogen",
    ft = "python",
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
  -- "sbdchd/neoformat",
  {
    "preservim/nerdcommenter",
    keys = {
      { "<F5>",       "<Plug>NERDCommenterToggle", mode = { "n", "v" }, desc = "NERDCommenter toggle" },
      { "<leader>cs", "<Plug>NERDCommenterSexy",   mode = { "n", "v" }, desc = "NERDCommenter comment out sexy" },
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
  {
    -- Detect tabs vs spaces
    'tpope/vim-sleuth',
    event = 'BufReadPre',
  },
  {
    -- Return to same line in file when reopening
    "ethanholz/nvim-lastplace",
    config = function()
      require 'nvim-lastplace'.setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase" },
        lastplace_open_folds = true
      }
    end
  },
  {
    -- Keep window layout when closing buffer
    "ojroques/nvim-bufdel",
    config = function()
      require('bufdel').setup {
        quit = false
      }
    end,
    keys = {
      { '<leader>bd', ':BufDel<cr>', mode = { 'n' }, desc = 'nvim-bufdel' },
    },
  },

  ------------------------------------------------------------
  -- Colorschemes / UI
  --
  {
    "pacha/vem-dark",
    enabled = true,
    init = function()
      vim.g.vem_colors_italic = 1
    end,
    config = function()
      vim.cmd('colorscheme vem-dark')
    end
  },
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
        },
        default = true,
      }
    end
  },
  -- # 'norcalli/nvim-colorizer.lua'
  {
    -- Show indent lines
    "lukas-reineke/indent-blankline.nvim",
    tag = 'v2.20.8',
    config = function()
      require("indent_blankline").setup {
        char_list = { '│', '¦', '┆', '┊' },
        filetype_exclude = { "help", "terminal", "list", "nofile", "man" },
        buftype_exclude = { "help", "terminal", "list", "nofile", "man" },
        bufname_exclude = { "man://.*" },
        show_current_context = true,
      }
    end
  },
  "kshenoy/vim-signature",          -- Add visual marks in gutter
  "ntpeters/vim-better-whitespace", -- causes all trailing whitespace characters to be highlighted.
  {
    -- Highlight TODO/FIXME and more
    "folke/todo-comments.nvim",
    config = true
  },
  "equalsraf/neovim-gui-shim", -- lazy.nvim breaks loading of ginit.vim, https://github.com/folke/lazy.nvim/issues/584
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
    dependencies = {
      "tpope/vim-repeat",
    },
    event = "BufEnter",
    keys = {
      { 'x', '"+x',                           mode = { 'n', 'x' },                 desc = 'Easyclip cut' },
      { "X", "<Plug>MoveMotionEndOfLinePlug", desc = "Easyclip cut to end of line" },
    },
    config = function()
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
      vim.g.ansible_template_syntaxes = {
        ['*.ya?ml.j2'] = 'yaml',
      }
    end
  },
  -- "andrewstuart/vim-kubernetes", -- Kubernetes + snippets
  {
    -- Syntax and more for tmux
    "tmux-plugins/vim-tmux",
    ft = "tmux"
  },
  "leafgarland/typescript-vim", -- TypeScript
  {
    -- vim syntax for helm templates (yaml + gotmpl + sprig + custom)
    "towolf/vim-helm",
    ft = "helm", -- https://github.com/mrjosh/helm-ls/issues/44
  },
  -- # 'pangloss/vim-javascript', { 'for': 'javascript' } JavaScript bundle for vim, this bundle provides syntax and indent plugins.
  -- # 'fatih/vim-go'
  "preservim/vim-markdown",
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
    enabled = false,
    dependencies = {
      {
        -- Handle vim.ui elements
        "stevearc/dressing.nvim",
        config = true,
      },
    },
    keys = {
      { "<leader>y", function() require("yaml-companion").open_ui_select() end, desc = "YAML companion UI open" }
    }
  },
  {
    -- Preview markdown
    "iamcco/markdown-preview.nvim",
    build = "cd app && npx --yes yarn install",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = "markdown",
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
  {
    -- Show function signature when you type
    "ray-x/lsp_signature.nvim",
    config = true,
  },
  {
    -- Lightweight yet powerful formatter plugin for Neovim
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        go = { "gofmt" },
        terraform = { "terraform_fmt" }
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
  {
    "nvimtools/none-ls.nvim",
    lazy = true,
    ft = { "go", "dockerfile", "lua", "python", "markdown" },
    event = { "BufNewFile", "BufReadPost" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        root_dir = require('null-ls.utils').root_pattern(".null-ls-root", "Makefile", ".git", ".flake8", "pyproject.toml"),
        sources = {
          null_ls.builtins.diagnostics.hadolint,
          null_ls.builtins.diagnostics.proselint,
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.diagnostics.trivy.with({
            extra_filetypes = { "dockerfile", "lua", "go", "gomod", "gowork", "gotmpl", "yaml", "yaml.ansible", "yaml.docker-compose" },
          }),
        },
      })
    end
  },
  {
    'mfussenegger/nvim-lint',
    enabled = false,
    -- optional = true,
    event = { "BufReadPost" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        -- sh = { "shellcheck" },
        python = { "flake8" },
        dockerfile = { "hadolint" }, -- trivy is broken
        -- go = { "trivy" },
        -- terraform = { "trivy" }
        markdown = { "proselint", "markdownlint" }
      }

      local lint_autogroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufwritePost", "InsertLeave" }, {
        group = lint_autogroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end
  },

  ------------------------------------------------------------
  -- Navigation / Fuzzy finders
  --
  -- # 'airblade/vim-rooter'
  {
    -- Set working to project directory
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pyproject.toml" },
        -- silent_chdir = false,
        ignore_lsp = { "null-ls" },
      }
    end,
  },
  {
    -- fzf.vim repository contains plugin, the other commands and mappings
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    cond = vim.fn.executable('fzf') == 1,
    cmd = { 'Files' },
    config = function()
      vim.env.FZF_DEFAULT_OPTS = '--keep-right -x --inline-info'
    end,
    keys = {
      { "<leader>bv", ":Buffers<cr>" },
      { "<leader>t",  ":Files<cr>" }
    }
  },

}
