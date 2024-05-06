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

-- -----------------------------------------------------------------------------
-- Missing treesitter highlight groups
--
vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { bg = "#303030" })
vim.api.nvim_set_hl(0, "@markup.heading", { link = 'Title' })
vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { bold = true })
vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { italic = true })
vim.api.nvim_set_hl(0, "@markup.strikethrough.markdown_inline", { strikethrough = true })
vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline",
  { bold = false, italic = true, underline = true, fg = "#aaaaff" })
vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { underline = true })
vim.api.nvim_set_hl(0, "@markup.heading.markdown", { bold = true })

local hi = function(name, val)
  -- Make sure that `cterm` attribute is not populated from `gui`
  val.cterm = val.cterm or {}

  -- Define global highlight
  vim.api.nvim_set_hl(0, name, val)
end

-- Text
hi('@markup.raw', { link = 'Comment' })
hi('@markup.link', { link = 'Identifier' })
hi('@markup.heading', { link = 'Title' })
hi('@markup.link.url', { link = 'Underlined' })
hi('@markup.underline', { link = 'Underlined' })
hi('@comment.todo', { link = 'Todo' })

-- Miscs
hi('@comment', { link = 'Comment' })
hi('@punctuation', { link = 'Delimiter' })

-- Constants
hi('@constant', { link = 'Constant' })
hi('@constant.builtin', { link = 'Special' })
hi('@constant.macro', { link = 'Define' })
hi('@keyword.directive', { link = 'Define' })
hi('@string', { link = 'String' })
hi('@string.escape', { link = 'SpecialChar' })
hi('@string.special', { link = 'SpecialChar' })
hi('@character', { link = 'Character' })
hi('@character.special', { link = 'SpecialChar' })
hi('@number', { link = 'Number' })
hi('@boolean', { link = 'Boolean' })
hi('@number.float', { link = 'Float' })

-- Functions
hi('@function', { link = 'Function' })
hi('@function.builtin', { link = 'Special' })
hi('@function.macro', { link = 'Macro' })
hi('@function.method', { link = 'Function' })
hi('@variable.parameter', { link = 'Identifier' })
hi('@variable.parameter.builtin', { link = 'Special' })
hi('@variable.member', { link = 'Identifier' })
hi('@property', { link = 'Identifier' })
hi('@attribute', { link = 'Macro' })
hi('@attribute.builtin', { link = 'Special' })
hi('@constructor', { link = 'Special' })

-- Keywords
hi('@keyword.conditional', { link = 'Conditional' })
hi('@keyword.repeat', { link = 'Repeat' })
hi('@keyword.type', { link = 'Structure' })
hi('@label', { link = 'Label' })
hi('@operator', { link = 'Operator' })
hi('@keyword', { link = 'Keyword' })
hi('@keyword.exception', { link = 'Exception' })

hi('@variable', { link = 'Identifier' })
hi('@type', { link = 'Type' })
hi('@type.definition', { link = 'Typedef' })
hi('@module', { link = 'Identifier' })
hi('@keyword.import', { link = 'Include' })
hi('@keyword.directive', { link = 'PreProc' })
hi('@keyword.debug', { link = 'Debug' })
hi('@tag', { link = 'Tag' })
hi('@tag.builtin', { link = 'Special' })

-- LSP semantic tokens
hi('@lsp.type.class', { link = 'Structure' })
hi('@lsp.type.comment', { link = 'Comment' })
hi('@lsp.type.decorator', { link = 'Function' })
hi('@lsp.type.enum', { link = 'Structure' })
hi('@lsp.type.enumMember', { link = 'Constant' })
hi('@lsp.type.function', { link = 'Function' })
hi('@lsp.type.interface', { link = 'Structure' })
hi('@lsp.type.macro', { link = 'Macro' })
hi('@lsp.type.method', { link = 'Function' })
hi('@lsp.type.namespace', { link = 'Structure' })
hi('@lsp.type.parameter', { link = 'Identifier' })
hi('@lsp.type.property', { link = 'Identifier' })
hi('@lsp.type.struct', { link = 'Structure' })
hi('@lsp.type.type', { link = 'Type' })
hi('@lsp.type.typeParameter', { link = 'TypeDef' })
hi('@lsp.type.variable', { link = 'Identifier' })
