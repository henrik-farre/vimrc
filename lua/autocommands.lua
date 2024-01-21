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
