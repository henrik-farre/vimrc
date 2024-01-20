-- -----------------------------------------------------------------------------
-- Disable Language providers
--
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- -----------------------------------------------------------------------------
--  Encoding
--
vim.scriptencoding = 'utf-8'
vim.opt.fileencodings = "utf-8"

-- -----------------------------------------------------------------------------
-- Leader
-- Needs to be set here, and not in bindings.vim as it is sourced to late
-- http://www.reddit.com/r/vim/comments/1vdrxg/space_is_a_big_key_what_do_you_map_it_to/
--
vim.g.mapleader = " "

-- -----------------------------------------------------------------------------
-- Disable swapfile when in a diff
-- the old syntax checker options do not exist anymore
--
if vim.opt.diff:get() then
  vim.o.noswapfile = true
end

-- -----------------------------------------------------------------------------
-- Search / Replace
--
vim.o.ignorecase = true     -- Do case insensitive matching, must be set for smartcase to work
vim.o.smartcase = true      -- Do smart case search - case sensitive if first letter in search is uppercase
vim.o.inccommand = "split"  -- Incremental replace, https://github.com/neovim/neovim/pull/5561
vim.o.gdefault = true       -- Applies substitutions globally on lines, /g to disable



vim.cmd.source(vim.fn.stdpath("config") .. "/old.vim")

-- Archlinux adds /usr/share/vim/vimfiles to rtp
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
-- Disable plugins:
--
vim.g.loaded_netrwPlugin = 1       -- netrw
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
