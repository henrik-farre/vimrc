-- -----------------------------------------------------------------------------
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- -----------------------------------------------------------------------------
  -- Diagnostics float open on cursor hold
  --
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })
end

local flags = {debounce_text_changes = 500}
-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion#nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "b0o/schemastore.nvim",
    -- "someone-stole-my-name/yaml-companion.nvim",
  },
  config = function()
    local servers = {
      'ansiblels',
      'bashls',
      'cssls',
      'dockerls',
      'groovyls',
      'html',
      'jsonls',
      'terraformls',
      'tflint',
      'pyright',
      'vimls',
      'helm_ls',
      'yamlls',
      'lua_ls',
      'gopls',
    }

    for _, name in ipairs(servers) do
      require("lsp." .. name).setup(on_attach, capabilities, flags)
    end
  end
}
