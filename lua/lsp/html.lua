return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").html.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
    })
  end,
}
