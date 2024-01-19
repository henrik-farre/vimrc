vim.cmd.source(vim.fn.stdpath("config") .. "/old.vim")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- -----------------------------------------------------------------------------
-- Load plugins and configure most of them
require("lazy").setup("plugins")
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
