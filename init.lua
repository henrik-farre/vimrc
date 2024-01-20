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

require("lazy").setup("plugins")
require('functions')
require('ui')

-- -----------------------------------------------------------------------------
-- Keymaps
--
vim.cmd.source(vim.fn.stdpath("config") .. "/bindings.vim")
