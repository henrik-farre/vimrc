-- -----------------------------------------------------------------------------------------------
-- Treesitter
--
if vim.loop.os_uname().machine == "aarch64" then
  return
end

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "dockerfile", "yaml", "python", "bash", "json", "javascript", "html", "css", "lua", "markdown", "toml" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  -- https://github.com/andymass/vim-matchup
  matchup = {
    enable = true
  },
}
