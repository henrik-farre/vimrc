-- -----------------------------------------------------------------------------
-- Toggle relativenumber on focus/insert
--
local custom_number_grp = vim.api.nvim_create_augroup('custom_number', { clear = true })
vim.api.nvim_create_autocmd({ 'FocusLost', 'InsertEnter' }, {
  group = custom_number_grp,
  callback = function()
    vim.opt_local.relativenumber = false
  end
})
vim.api.nvim_create_autocmd({ 'FocusGained', 'InsertLeave' }, {
  group = custom_number_grp,
  callback = function()
    vim.opt_local.relativenumber = true
  end
})

-- -----------------------------------------------------------------------------
-- Only show cursorline in active window/buffer
--
local custom_cursorline_grp = vim.api.nvim_create_augroup('custom_cursorline', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
  group = custom_cursorline_grp,
  callback = function()
    vim.opt_local.cursorline = true
  end
})
vim.api.nvim_create_autocmd({ 'WinLeave' }, {
  group = custom_cursorline_grp,
  callback = function()
    vim.opt_local.cursorline = false
  end
})
