-- -----------------------------------------------------------------------------
-- TODO: duplicated in both yamlls and helm_ls
--
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
      singleQuote = false,
      bracketSpacing = false,
      proseWrap = "preserve",
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
local replace = {}
local ignore = {}

if vim.env.NVIM_YAMLLS_USE_OVERRIDES then
  local overrides = require('lsp.yaml_overrides')
  extras = overrides.extras()
  replace = overrides.replace()
  ignore = overrides.ignore()
end

settings.yaml.schemas = require('schemastore').yaml.schemas({
  extra = extras,
  replace = replace,
  ignore = ignore,
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
  settings = settings,
}
