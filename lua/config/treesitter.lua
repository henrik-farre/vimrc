-- -----------------------------------------------------------------------------------------------
-- Treesitter
--
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "dockerfile", "yaml", "python", "bash", "json", "javascript", "html", "css", "lua", "markdown" },
  highlight = {
    enable = true,
  },
  -- indent = {
  --   enable = true,
  -- },
  incremental_selection = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
}
