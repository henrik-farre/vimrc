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