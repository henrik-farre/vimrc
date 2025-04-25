local setlocal = vim.opt_local

setlocal.expandtab = false
setlocal.tabstop = 4
setlocal.shiftwidth = 4
setlocal.softtabstop = 4

vim.lsp.enable("gopls")
