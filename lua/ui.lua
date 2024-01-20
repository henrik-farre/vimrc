-- -----------------------------------------------------------------------------
-- Window titles
--
vim.opt.title = true
vim.opt.titlelen = 0 -- do not shorten title
vim.opt.titlestring = 'nvim %{expand("%:p")} %M'

-- -----------------------------------------------------------------------------
-- Colors
--
vim.opt.termguicolors = true

-- -----------------------------------------------------------------------------
-- Colorscheme
--
vim.g.vem_colors_italic = 1
vim.cmd("colorscheme vem-dark")

-- -----------------------------------------------------------------------------
-- Vimscript UI settings
--
vim.cmd.source(vim.fn.stdpath("config") .. "/ui.vim")
