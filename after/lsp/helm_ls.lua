local yaml_settings = require('lsp.yaml_settings').setup()

return {
  settings = {
    ["helm-ls"] = {
      logLevel = "debug",
      yamlls = {
        enabled = true,
        config = yaml_settings,
      },
    },
  },
}
