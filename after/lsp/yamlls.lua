local yaml_settings = require('lsp.yaml_settings').setup()

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
  settings = yaml_settings,
}
