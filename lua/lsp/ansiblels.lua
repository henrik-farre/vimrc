return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").ansiblels.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
      filetypes = { "yaml.ansible" },
      settings = {
        ansible = {
          ansible = {
            useFullyQualifiedCollectionNames = true
          },
          validation = {
            enabled = true,
            lint = {
              enabled = true,
            }
          }
        }
      }
    })
  end,
}
