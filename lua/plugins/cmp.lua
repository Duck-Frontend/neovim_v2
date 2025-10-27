local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-g>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.abort()  -- Закрыть меню дополнения
        vim.defer_fn(function()
          vim.lsp.buf.definition()  -- Перейти к определению
        end, 50)
      else
        vim.lsp.buf.definition()  -- Обычный переход
      end
    end, { 'i', 'n' }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'emoji' },
  }),
})

formatting = {
    format = require('tailwindcss-colorizer-cmp').formatter
  }
})
