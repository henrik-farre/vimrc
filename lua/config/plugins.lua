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
  require("yaml_nvim").setup({ ft = { "yaml", "helm" } })
end
