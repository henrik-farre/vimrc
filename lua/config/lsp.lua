-- -----------------------------------------------------------------------------------------------
-- LSP setup
--
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'ansiblels', 'bashls', 'cssls', 'dockerls', 'groovyls', 'html', 'jsonls', 'null-ls', 'terraformls', 'tflint', 'pyright', 'vimls', 'yamlls' }
local nvim_lsp = require('lspconfig')

-- null-ls setup
if vim.g.plugs['null-ls.nvim'] then
  local null_ls = require("null-ls")
  local sources = {
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.shellcheck,
  }

  null_ls.config({ sources = sources })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "rounded"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "rounded"
  }
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = false,
    virtual_text = true,
    signs = true,
    update_in_insert = false,
  }
)

local function make_config(server)
  local config = {}
  config.on_attach = on_attach
  config.flags = {debounce_text_changes = 500}
  if vim.g.plugs['nvim-cmp'] then
    config.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  end

  if server == 'ansiblels' then
    config.filetypes = { "yaml.ansible" }
    config.settings = {
      ansible = {
        ansible = {
          path = "/usr/bin/ansible"
        },
        ansibleLint = {
          enabled = true,
          path = "/usr/bin/ansible-lint",
          arguments = "-x yaml"
        },
        python = {
          interpreterPath = "/usr/bin/python3"
        }
      }
    }
  elseif server == 'yamlls' then
    config.settings = {
        yaml = {
          validate = true,
          hover = true,
          completion = true,
          schemas = {
            -- Schemas should work out of the box
            -- ['https://json.schemastore.org/github-workflow.json'] = '.github/workflows/*.{yml,yaml}',
            -- ['https://json.schemastore.org/github-action.json'] = '.github/action.{yml,yaml}',
            kubernetes = {
              "clusterrolebinding.yaml",
              "clusterrole-contour.yaml",
              "clusterrole.yaml",
              "configmap.yaml",
              "cronjob.yaml",
              "daemonset.yaml",
              "deployment-*.yaml",
              "deployment.yaml",
              "*-deployment.yaml",
              "hpa.yaml",
              "ingress.yaml",
              "job.yaml",
              "namespace.yaml",
              "pod.yaml",
              "pv.yaml",
              "pvc.yaml",
              "rbac.yaml",
              "rolebinding.yaml",
              "role.yaml",
              "sa.yaml",
              "secret.yaml",
              "serviceaccounts.yaml",
              "service-account.yaml",
              "serviceaccount.yaml",
              "service-*.yaml",
              "service.yaml",
              "*-service.yaml",
              "statefulset.yaml",
            }
          }
        }
      }
  elseif server == 'jsonls' then
    config.cmd = { "vscode-json-languageserver", "--stdio" }
    config.settings = {
      json = {
        schemas = {
          {
            fileMatch = { 'Packer/**/*.json' },
            url = 'https://json.schemastore.org/packer.json',
          }
        }
      }
    }
  elseif server == 'html' then
    config.cmd = { "vscode-html-languageserver", "--stdio" }
  elseif server == 'cssls' then
    config.cmd = { "vscode-css-languageserver", "--stdio" }
  elseif server == 'groovyls' then
     config.cmd = { "java", "-jar", "/usr/share/java/groovy-language-server/groovy-language-server-all.jar" }
  end

  return config
end

for _, server in ipairs(servers) do
  local config = make_config(server)

  nvim_lsp[server].setup(config)
end

local signs = { Error = "", Warning = "", Hint = "", Information = "" }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- -----------------------------------------------------------------------------------------------
-- LSP kind: show icons for completions
--
if vim.g.plugs['lspkind-nvim'] then
require('lspkind').init({
    with_text = true,
    preset = 'default',

    symbol_map = {
      Class = "ﴯ",
      Color = "",
      Constant = "",
      Constructor = '',
      Enum = "",
      EnumMember = '',
      Event = "",
      Field = "ﰠ",
      File = "",
      Folder = "",
      Function = '',
      Interface = "",
      Keyword = "",
      Method = 'ƒ',
      Module = '',
      Operator = "",
      Property = "ﰠ",
      Reference = "",
      Snippet = "",
      Struct = '',
      Text = '',
      TypeParameter = "",
      Unit = "塞",
      Value = "",
      Variable = '',
    },
})
end

-- -----------------------------------------------------------------------------------------------
-- LSP colors, highlightning of messages for colorschemes that does not support
-- those groups
--
if vim.g.plugs['lsp-colors'] then
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})
end

-- -----------------------------------------------------------------------------------------------
-- Trouble, A pretty list for showing diagnostics, references, telescope
-- results, quickfix and location lists to help you solve all the trouble your
-- code is causing.
if vim.g.plugs['trouble.nvim'] then
  require("trouble").setup {
    mode = "lsp_document_diagnostics"
  }
end
