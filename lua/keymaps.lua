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
local set = vim.keymap.set

set('n', '<leader>v', function() vim.cmd.edit(vim.env.MYVIMRC) end) -- opens $MYVIMRC for editing
set('n', '<leader>ts', function() TrimWhiteSpace() end, { silent = true })

--- Default <C-L> is used by split navigation so use <C-n>
set('n', '<C-n>', '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>', {
  desc = 'Clear search highlight',
})

-- Save keystrokes on save
-- https://vim.wikia.com/wiki/Use_Ctrl-O_instead_of_Esc_in_insert_mode_mappings
set({'i', 'n'}, '<C-s>', vim.cmd.wall)

-- expands %% to current file's directory in command-line mode
set('c', '%%', function()
  vim.api.nvim_feedkeys(vim.fn.expand('%:p:h') .. '/', 'c', false)
end)

-- -----------------------------------------------------------------------------
-- Disable existing maps
--
set('', '<F1>', '<Nop>') -- Disable help
set('n', '<C-a>', '<Nop>') -- Disable increment of numbers, clashes with tmux

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

set('', '<Up>', vc('k'), { expr = true, silent = true })
set('i', '<Up>', '<C-o>gk', { silent = true })
set('', '<Down>', vc('j'), { expr = true, silent = true })
set('i', '<Down>', '<C-o>gj', { silent = true })
set('', '<Home>', 'g<Home>', { silent = true })
set('i', '<Home>', '<C-o>g<Home>', { silent = true })
set('', '<End>', 'g<End>', { silent = true })
set('i', '<End>', '<C-o>g<End>', { silent = true })
set('n', 'k', vc('k'), { expr = true, silent = true })
set('n', 'j', vc('j'), { expr = true, silent = true })

set('', '$', 'g$', { buffer = true, silent = true })

-- Move cursor to first char on line on first press, next press goes to beginning of line
set('n', '0', function() ToggleHomeZero() end, { silent = true })

-- Map ' so it jumps to line and column
set('n', "'", "`")
set('n', "`", "'")

-- -----------------------------------------------------------------------------
-- Split navigation
--
-- http://robots.thoughtbot.com/vim-splits-move-faster-and-more-naturally
set('n', '<C-j>', '<C-W><C-j>')
set('n', '<C-k>', '<C-W><C-k>')
set('n', '<C-l>', '<C-W><C-l>')
set('n', '<C-h>', '<C-W><C-h>')

-- -----------------------------------------------------------------------------
-- Split creation
--
-- GUIs (nvim-qt)
set('n', '<C-|>', '<C-W>v')
set('n', '<C-S-_>', '<C-W>s')
-- Terminals (tmux)
set('n', '<C-\\>', '<C-W>v')
set('n', '<C-_>', '<C-W>s')

-- -----------------------------------------------------------------------------
-- Change indent
--
-- https://github.com/mkropat/vim-dwiw2015/blob/master/plugin/dwiw2015.vim#L212
set('v', '>', '>gv')  -- shift selection rightwards (preserve selection) [Visual Mode]
set('v', '<', '<gv')  -- shift selection leftwards (preserve selection) [Visual Mode]

-- -----------------------------------------------------------------------------
-- Buffer navigation
--
-- Switch buffers using <leader>bn/bp, skips quickfix because autocmd has set it to nobuflisted
set('n', '<leader>bn', ':bn<cr>')
set('n', '<leader>bp', ':bp<cr>')

-- -----------------------------------------------------------------------------
-- Yanking/pasting
--
-- Select pasted text, companion function to gv
set('n', 'gV', '`[v`]')

-- Fix indent when pasting in insert mode
-- https://www.reddit.com/r/neovim/comments/ywn367/til_pasting_with_crco_instead_of_cr_in_insert/
set('i', '<C-r>', '<C-r><C-o>')

-- yank till the end of the line
-- https://github.com/neovim/neovim/pull/13268
set('n', 'Y', '"+y$')
