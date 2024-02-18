-- -----------------------------------------------------------------------------
-- Cursor
--
vim.api.nvim_set_hl(0, "Cursor", { fg="white", bg="#0d61ac" })
vim.api.nvim_set_hl(0, "CursorInsert", { fg="white", bg="#437019" })
vim.api.nvim_set_hl(0, "CursorVisual", { fg="white", bg="#870000" })

-- -----------------------------------------------------------------------------
-- Change split background between windows
--
vim.api.nvim_set_hl(0, "VertSplit", { bg="NONE", fg="#444444" })

-- -----------------------------------------------------------------------------
-- Indent blankline
--
vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg="#2f2f2f" })

-- -----------------------------------------------------------------------------
-- Trailing whitespace
--
vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg="#4e2f2f" })

-- -----------------------------------------------------------------------------
-- vim-signature
--
vim.api.nvim_set_hl(0, "SignatureMarkText", { bold=true, fg="#aeee04" })

-- -----------------------------------------------------------------------------
-- Visual selection
--
vim.api.nvim_set_hl(0, "Visual", { fg="#000000", bg="LightBlue" })

-- -----------------------------------------------------------------------------
-- Visual selection
--
vim.api.nvim_set_hl(0, "DiagnosticError", { fg="red", bg="#111111" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg="yellow" ,bg="#111111" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg="green", bg="#111111" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg="blue", bg="#111111" })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { bg="#111111" })

-- -----------------------------------------------------------------------------
-- CMP
--
-- cmp highlighting - https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

-- -----------------------------------------------------------------------------
-- Highlight VCS conflict markers
--
-- Based on https://bitbucket.org/sjl/dotfiles/src/141b96496989091fce4aa5165946f94d31c2374f/vim/vimrc
vim.fn.matchadd("ErrorMsg", [[^\(<\|=\|>\)\{7\}\([^=].\+\)\?$]])

-- -----------------------------------------------------------------------------
-- Diagnostic float
--
vim.api.nvim_set_hl(0, 'NormalFloat', { bg='NONE' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg='NONE', fg='white' })
vim.api.nvim_set_hl(0, 'DiagnosticFloatingError', { bg='NONE', fg='#ff0000'})
