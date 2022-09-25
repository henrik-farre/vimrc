-- Setup nvim-cmp.
if vim.g.plugs['nvim-cmp'] then
  local cmp = require'cmp'
  local lspkind = require('lspkind')

  cmp.setup({
    completion = {
      -- only complete when 2+ characters match,
      -- that will increas performance and make it less annoying
      keyword_length = 2,
    },
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = 'symbol_text', -- show only symbol annotations
        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

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
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
      {
        name = 'buffer',
        keyword_length = 2,
      },
      { name = 'path' },
      { name = 'emoji' },
      { name = 'nvim_lua' },
      { name = "git" },
    }
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
      { name = 'path' }
    }, {
      { name = 'cmdline', max_item_count = 10, keyword_length = 2  }
    })
  })
end

require("cmp_git").setup()
