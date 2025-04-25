return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "b0o/schemastore.nvim",
    -- "someone-stole-my-name/yaml-companion.nvim",
  },
  config = function()
    -- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities,
    })
    -- vim.lsp.set_log_level 'trace'
  end
}
