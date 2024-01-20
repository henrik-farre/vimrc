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
-- Sign column settings
--
vim.o.number = true                 -- Line numbers
vim.o.relativenumber = true
vim.o.signcolumn = "yes:1"          -- Always show 1 sign column
vim.o.numberwidth = 3               -- Use less space for line numbering if possible

-- -----------------------------------------------------------------------------
-- Vimscript UI settings
--
vim.cmd.source(vim.fn.stdpath("config") .. "/ui.vim")
