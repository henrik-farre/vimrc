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
