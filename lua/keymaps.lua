-- -----------------------------------------------------------------------------
-- Keymaps
--
--[[
  n: Normal
  i: Insert
  x: Visual
  s: Selection
  v: Visual + Selection
  t: Terminal
  o: Operator pending
  '': Equivalent of n + v + o
--]]

vim.keymap.set('n', '<leader>v', function() vim.cmd.edit(vim.env.MYVIMRC) end) -- opens $MYVIMRC for editing
vim.keymap.set('n', '<leader>ts', function() TrimWhiteSpace() end, { silent = true })

--- Default <C-L> is used by split navigation so use <C-n>
vim.keymap.set('n', '<C-n>', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', {
  desc = 'Clear search highlight',
})

-- Save keystrokes on save
-- https://vim.wikia.com/wiki/Use_Ctrl-O_instead_of_Esc_in_insert_mode_mappings
vim.keymap.set({'i', 'n'}, '<C-s>', vim.cmd.wall)

-- expands %% to current file's directory in command-line mode
vim.keymap.set('c', '%%', function()
  vim.api.nvim_feedkeys(vim.fn.expand('%:p:h') .. '/', 'c', false)
end)

-- -----------------------------------------------------------------------------
-- Disable existing maps
--
vim.keymap.set('', '<F1>', '<Nop>') -- Disable help
vim.keymap.set('n', '<C-a>', '<Nop>') -- Disable increment of numbers, clashes with tmux

-- -----------------------------------------------------------------------------
-- Movement
--
-- More natural arrow + navigation keys movement
-- Fix moving pass visual wrapped lines: https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
local vc = function(key)
  -- vim.v.count is number of lines to move
  return function()
    return (vim.v.count == 0 and 'g' or '') .. key
  end
end

vim.keymap.set('', '<Up>', vc('k'), { expr = true, silent = true })
vim.keymap.set('i', '<Up>', '<C-o>gk', { silent = true })
vim.keymap.set('', '<Down>', vc('j'), { expr = true, silent = true })
vim.keymap.set('i', '<Down>', '<C-o>gj', { silent = true })
vim.keymap.set('', '<Home>', 'g<Home>', { silent = true })
vim.keymap.set('i', '<Home>', '<C-o>g<Home>', { silent = true })
vim.keymap.set('', '<End>', 'g<End>', { silent = true })
vim.keymap.set('i', '<End>', '<C-o>g<End>', { silent = true })
vim.keymap.set('n', 'k', vc('k'), { expr = true, silent = true })
vim.keymap.set('n', 'j', vc('j'), { expr = true, silent = true })

vim.keymap.set('', '$', 'g$', { buffer = true, silent = true })

-- Move cursor to first char on line on first press, next press goes to beginning of line
vim.keymap.set('n', '0', function() ToggleHomeZero() end, { silent = true })

-- Map ' so it jumps to line and column
vim.keymap.set('n', "'", "`")
vim.keymap.set('n', "`", "'")

-- -----------------------------------------------------------------------------
-- Split navigation
--
-- http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
vim.keymap.set('n', '<C-j>', '<C-W><C-j>')
vim.keymap.set('n', '<C-k>', '<C-W><C-k>')
vim.keymap.set('n', '<C-l>', '<C-W><C-l>')
vim.keymap.set('n', '<C-h>', '<C-W><C-h>')

-- -----------------------------------------------------------------------------
-- Split creation
--
-- GUIs (nvim-qt)
vim.keymap.set('n', '<C-|>', '<C-W>v')
vim.keymap.set('n', '<C-S-_>', '<C-W>s')
-- Terminals (tmux)
vim.keymap.set('n', '<C-\\>', '<C-W>v')
vim.keymap.set('n', '<C-_>', '<C-W>s')

-- -----------------------------------------------------------------------------
-- Change indent
--
-- https://github.com/mkropat/vim-dwiw2015/blob/master/plugin/dwiw2015.vim#L212
vim.keymap.set('v', '>', '>gv')  -- shift selection rightwards (preserve selection) [Visual Mode]
vim.keymap.set('v', '<', '<gv')  -- shift selection leftwards (preserve selection) [Visual Mode]

-- -----------------------------------------------------------------------------
-- Buffer navigation
--
-- Switch buffers using <leader>bn/bp, skips quickfix because autocmd has set it to nobuflisted
vim.keymap.set('n', '<leader>bn', ':bn<cr>')
vim.keymap.set('n', '<leader>bp', ':bp<cr>')

-- -----------------------------------------------------------------------------
-- Yanking/pasting
--
-- Select pasted text, companion function to gv
vim.keymap.set('n', 'gV', '`[v`]')

-- Fix indent when pasting in insert mode
-- https://www.reddit.com/r/neovim/comments/ywn367/til_pasting_with_crco_instead_of_cr_in_insert/
vim.keymap.set('i', '<C-r>', '<C-r><C-o>')

-- yank till the end of the line
-- https://github.com/neovim/neovim/pull/13268
vim.keymap.set('n', 'Y', '"+y$')
