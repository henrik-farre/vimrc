return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local servers = { 'ansiblels', 'bashls', 'cssls', 'dockerls', 'groovyls', 'html', 'jsonls', 'terraformls', 'tflint', 'pyright', 'vimls', 'helm_ls', 'yamlls', }
    local nvim_lsp = require('lspconfig')

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      -- Enable completion triggered by <c-x><c-o>
      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      local opts = { noremap=true, silent=true }

      -- Avoid yamlls on helm files
      -- https://www.reddit.com/r/neovim/comments/rwoxne/nvimlspconfig_helm_chart_templates/
      -- https://www.reddit.com/r/neovim/comments/sqr6r5/helm_charts_for_kubernetes_in_nvim_bad_experience/
      if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "yaml.gotexttmpl" or vim.bo[bufnr].filetype == "helm" then
        vim.diagnostic.disable(bufnr)
        vim.defer_fn(function()
          vim.diagnostic.reset(nil, bufnr)
        end, 1000)
      end

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
      buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      -- https://jdhao.github.io/2021/12/01/nvim_v06_released/
      buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
      buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end

    -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
    vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=none]]
    vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=none]]

    -- Configure diagnostic display
    vim.diagnostic.config({
        virtual_text = false,
        float = {
            severity_sort = true,
            -- source = "if_many",
            border = "rounded",
            header = {
                " ",
                "LspDiagnosticsDefaultWarning",
            },
            prefix = function(diagnostic)
                local diag_to_format = {
                    [vim.diagnostic.severity.ERROR] = { "Error", "LspDiagnosticsDefaultError" },
                    [vim.diagnostic.severity.WARN] = { "Warning", "LspDiagnosticsDefaultWarning" },
                    [vim.diagnostic.severity.INFO] = { "Info", "LspDiagnosticsDefaultInfo" },
                    [vim.diagnostic.severity.HINT] = { "Hint", "LspDiagnosticsDefaultHint" },
                }
                local res = diag_to_format[diagnostic.severity]
                return string.format("(%s) ", res[1]), res[2]
            end,
        },
        severity_sort = true,
    })

    vim.api.nvim_create_autocmd("CursorHold", {
      buffer = bufnr,
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end
    })

    local function make_config(server)
      local config = {}
      config.on_attach = on_attach
      config.flags = {debounce_text_changes = 500}
      -- use cmp to setup default_capabilities
      config.capabilities = require("cmp_nvim_lsp").default_capabilities()

      if server == 'ansiblels' then
        config.filetypes = { "yaml.ansible" }
        config.settings = {
          ansible = {
            ansible = {
              path = "/usr/bin/ansible",
              useFullyQualifiedCollectionNames = true
            },
            ansibleLint = {
              enabled = true,
              path = "/usr/bin/ansible-lint",
              arguments = "-x yaml"
            }
          }
        }
      elseif server == 'yamlls' then
        config = require("yaml-companion").setup({
          lspconfig = {
            on_attach = config.on_attach,
            flags = config.flags,
            capabilities = config.capabilities
          },
        })
      elseif server == 'jsonls' then
        config.settings = {
          json = {
            schemas = {
              {
                fileMatch = { 'Packer/**/*.json' },
                url = 'https://json.schemastore.org/packer.json',
              },
              {
                fileMatch = {"**/filespecs/*.json", "*filespec*.json", "*.filespec", "**/specs/*.json"},
                url = "https://raw.githubusercontent.com/jfrog/jfrog-cli/v2/schema/filespec-schema.json"
              }
            }
          }
        }
      elseif server == 'groovyls' then
        config.cmd = { "java", "-jar", "/usr/share/java/groovy-language-server/groovy-language-server-all.jar" }
      end

      return config
    end

    for _, server in ipairs(servers) do
      local config = make_config(server)

      nvim_lsp[server].setup(config)
    end

    local signs = { Error = "", Warn = "", Hint = "", Info = "" }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end
}
