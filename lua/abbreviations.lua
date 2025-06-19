-- -----------------------------------------------------------------------------
-- Typos
-- http://blog.sanctum.geek.nz/vim-command-typos/
-- http://vim.wikia.com/wiki/Handle_common_command_typos
vim.cmd("cnoreabbrev q1 q!")
vim.cmd("cnoreabbrev Qa qa")
vim.cmd("cnoreabbrev wQ wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev Wqa wqa")
vim.cmd("cnoreabbrev WQa wqa")
vim.cmd("cnoreabbrev waq wqa")
vim.cmd("cnoreabbrev qwa wqa")

-- TODO:after neovim 0.10 release:
-- vim.keymap.set("ca", "WQ", "wq")

-- -----------------------------------------------------------------------------
-- Abbrevs
--
vim.cmd([[
  iabbrev seperator separator
  iabbrev lenght length
  iabbrev cluser cluster
  iabbrev lastest latest
]])
