return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").tflint.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
    })
  end,
}
