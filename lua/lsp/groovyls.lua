return {
  setup = function(on_attach, capabilities, flags)
    require("lspconfig").groovyls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
      cmd = { "java", "-jar", "/usr/share/java/groovy-language-server/groovy-language-server-all.jar" },
    })
  end,
}
