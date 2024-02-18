return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").terraformls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
    })
  end,
}
