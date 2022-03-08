-- Setup nvim-cmp.
if vim.g.plugs['nvim-cmp'] then
  local cmp = require'cmp'
  local lspkind = require('lspkind')

  cmp.setup({
    completion = {
      -- only complete when 3+ characters match,
      -- that will increas performance and make it less annoying
      keyword_length = 3,
    },
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    formatting = {
      format = lspkind.cmp_format({
        menu = ({
          buffer = "[BUF]",
          nvim_lsp = "[LSP]",
          ultisnips = "[SNIP]",
          nvim_lua = "[LUA]",
          path = "[PATH]",
          emoji = "[EMOJ]",
        })
      }),
    },
    documentation = {
      border = "rounded",
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
      {
        name = 'buffer',
        keyword_length = 3,
      },
      { name = 'path' },
      { name = 'emoji' },
      { name = 'nvim_lua' },
    }
  })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      {
        name = 'buffer',
        keyword_length = 3,
      },
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline', max_item_count = 10, keyword_length = 2  }
    })
  })
end
