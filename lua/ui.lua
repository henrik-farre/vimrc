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
-- Sign column settings
--
vim.o.number = true        -- Line numbers
vim.o.relativenumber = true
vim.o.signcolumn = "yes:1" -- Always show 1 sign column
vim.o.numberwidth = 3      -- Use less space for line numbering if possible

-- -----------------------------------------------------------------------------
-- List chars - show invisible characters
--
vim.o.list = true
vim.opt.listchars = {
  tab = "→ ", -- indent line might hide this
  extends = "»",
  precedes = "«",
  nbsp = "·",
}

-- -----------------------------------------------------------------------------
-- Fillchars - UI elements
--
vim.opt.fillchars = {
  eob = " ", -- suppress ~ at EndOfBuffer
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
vim.o.updatetime = 250 -- Used for CursorHold event, makes floating windows appear faster

-- -----------------------------------------------------------------------------
-- Split settings
--
vim.o.splitkeep = "cursor" -- Keep windows stable when opening trouble and more

-- More natural split opening
-- http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
vim.o.splitbelow = true
vim.o.splitright = true

-- -----------------------------------------------------------------------------
-- Cursor
--
vim.opt.guicursor = "a:blinkwait600-blinkoff450-blinkon500,sm:block-blinkwait175-blinkoff150-blinkon175"
vim.opt.guicursor:append("n-c:block-Cursor,v:block-CursorVisual,i-ci-ve:ver25-CursorInsert,r-cr:hor20,o:hor50")
vim.o.cursorline = true

-- -----------------------------------------------------------------------------
-- Mouse
--
vim.o.mousemodel = "popup"
vim.o.mouse = "ar" -- Mouse on, all modes + hit-enter/more-prompt

-- -----------------------------------------------------------------------------
-- Command line
--
vim.o.cmdheight = 1  -- The command line is 1 high
vim.o.laststatus = 3 -- Global status line

if vim.opt.diff:get() then
  -- Fixes "press enter or type command to continue"
  vim.o.cmdheight = 2
end

vim.o.showmode = false -- Do not show mode in command line

-- -----------------------------------------------------------------------------
-- Diagnostics
--
-- Configure diagnostic display
vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = "󰋼 ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
  },
  float = {
    severity_sort = true,
    -- source = "if_many",
    border = "rounded",
    header = { '\u{F188} Diagnostics', 'Title' },
    prefix = function(diagnostic)
      local diag_to_format = {
        [vim.diagnostic.severity.ERROR] = { "Error", "LspDiagnosticsDefaultError" },
        [vim.diagnostic.severity.WARN] = { "Warning", "LspDiagnosticsDefaultWarning" },
        [vim.diagnostic.severity.INFO] = { "Info", "LspDiagnosticsDefaultInfo" },
        [vim.diagnostic.severity.HINT] = { "Hint", "LspDiagnosticsDefaultHint" },
      }
      local res = diag_to_format[diagnostic.severity]
      return string.format("(%s) ", res[1]), res[2]
    end,
  },
  severity_sort = true,
})
