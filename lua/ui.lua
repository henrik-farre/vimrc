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
-- List chars - show invisible characters
--
vim.o.list = true
vim.opt.listchars = {
  tab = "→ ",                       -- indent line might hide this
  extends = "»",
  precedes = "«",
  nbsp = "·",
}

-- -----------------------------------------------------------------------------
-- Fillchars - UI elements
--
vim.opt.fillchars = {
  vert = '┃',                       -- HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
  fold = '─',
  eob = " ",                        -- suppress ~ at EndOfBuffer
  diff = '⣿',
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
}

-- -----------------------------------------------------------------------------
-- Vertical/horizontal scroll off settings
--
-- Keep lines between the cursor and sides/bottom/top
vim.o.scrolloff = 10
vim.o.sidescrolloff = 7

-- -----------------------------------------------------------------------------
-- Update time
--
vim.o.updatetime=250                -- Used for CursorHold event, makes floating windows appear faster

-- -----------------------------------------------------------------------------
-- Split settings
--
vim.o.splitkeep = "cursor"          -- Keep windows stable when opening trouble and more

-- More natural split opening
-- http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
vim.o.splitbelow = true
vim.o.splitright = true

-- -----------------------------------------------------------------------------
-- Vimscript UI settings
--
vim.cmd.source(vim.fn.stdpath("config") .. "/ui.vim")
