local settings = {
  redhat = {
    telemetry = {
      enabled = false
    }
  },
  yaml = {
    validate = true,
    completion = true,
    hover = true,
    format = {
      enable = true,
      singleQuote = true,
      bracketSpacing = true,
    },
    schemaDownload = { enable = true },
    -- Configured for SchemaStore plugin
    schemaStore = {
      enable = false,
      -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
      url = "",
    },
  }
}

local extras = {}

if vim.env.NVIM_YAMLLS_SCHEMA_URI then
  local URI = vim.env.NVIM_YAMLLS_SCHEMA_URI
  extras = {
    {
      description = "K8s with local schema",
      fileMatch = {
        '*onfigma*.y*ml',
        '*eployment*.y*ml',
        '*ervic*.y*ml',
        '*ngres*.y*ml',
        '*ecre*.y*ml',
        '*stateful*.y*ml',
        'pod.y*ml',
        '*ame*pace*.y*ml',
        '*aemon*et*.y*ml',
        '*hpa*.y*ml',
        '*pv*.y*ml',
        '*ron*ob*.y*ml',
        },
      name = "configmap.json",
      url = URI .. '/all.json',
    }
  }
end

settings.yaml.schemas = require('schemastore').yaml.schemas({
  extra = extras
})

--[[
   [ local cfg = require("yaml-companion").setup({
   [   builtin_matchers = {
   [     -- Detects Kubernetes files based on content
   [     kubernetes = { enabled = false },
   [     cloud_init = { enabled = true }
   [   },
   [   lspconfig = {
   [     on_attach = on_attach,
   [     capabilities = capabilities,
   [     flags = flags,
   [     settings = settings,
   [   },
   [ })
   ]]

return {
  setup = function(on_attach, capabilities, flags)
    -- require("lspconfig").yamlls.setup(cfg)
    require("lspconfig").yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = flags,
      settings = settings,
    })
  end,
  config = function()
    return settings
  end,
}
