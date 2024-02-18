local yamlls_settings = require('lsp.yamlls').config()

return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").helm_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
      settings = {
          ["helm-ls"] = {
            logLevel = "debug",
            yamlls = {
              enabled = true,
              config = yamlls_settings.yaml,
            },
          },
        },
    })
  end,
}
