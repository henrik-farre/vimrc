return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-nvim-lsp",
    -- # 'hrsh7th/cmp-path'
    "https://codeberg.org/FelipeLema/cmp-async-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-emoji",
    "quangnguyen30192/cmp-nvim-ultisnips",
    {
      "petertriho/cmp-git",
      config = true,
    },
    "onsails/lspkind-nvim", -- This tiny plugin adds vscode-like pictograms to neovim built-in lsp
    "nvim-lua/plenary.nvim",
  },
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    -- Setup nvim-cmp.
    local cmp = require('cmp')
    local lspkind = require('lspkind')

    cmp.setup({
      completion = {
        -- only complete when 2+ characters match,
        -- that will increas performance and make it less annoying
        keyword_length = 2,
      },
      matching = {
          disallow_fuzzy_matching = true,
          disallow_partial_matching = true
      },
      snippet = {
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body)
        end,
      },
      formatting = {
        format = lspkind.cmp_format({
          mode = 'symbol_text', -- show only symbol annotations
          -- maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function (entry, vim_item)
            if entry.source.name == "buffer" then
              vim_item.menu = "[Buffer]"
            elseif entry.source.name == "nvim_lsp" then
              vim_item.menu = '{' .. entry.source.source.client.name .. '}'
            else
              vim_item.menu = '[' .. entry.source.name .. ']'
            end

            return vim_item
          end
        })
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      sources = {
        {
          name = 'nvim_lsp',
          max_item_count = 25
        },
        { name = 'ultisnips' },
        {
          name = 'buffer',
          keyword_length = 2,
        },
        { name = 'async_path' },
        { name = 'emoji' },
        { name = 'nvim_lua' },
      }
    })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = 'buffer' },
        })
      })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        {
          name = 'buffer',
          keyword_length = 2,
        },
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'async_path' }
      }, {
        { name = 'cmdline', max_item_count = 10, keyword_length = 2  }
      })
    })
  end
}
