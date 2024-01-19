vim.cmd.source(vim.fn.stdpath("config") .. "/old.vim")

-- -----------------------------------------------------------------------------
-- Load plugins and configure most of them
require('config.plugins')
-- LSP setup
-- LSP kind
-- LSP colors
-- Trouble
require('config.lsp')
-- Treesitter
require('config.treesitter')
-- nvim cmp
require('config.cmp')
-- lua functions
require('config.functions')
-- UI
require('config.ui')

-- -----------------------------------------------------------------------------
-- Keymaps
--
vim.cmd.source(vim.fn.stdpath("config") .. "/bindings.vim")
