local cmp = require('cmp')
local luasnip = require('luasnip')


cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({


    -- Tab/Shift-Tab
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),


    -- Подтверждение
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),

sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'luasnip' }, 
  { name = 'buffer' },    
  { name = 'path' },       
  { name = 'emoji' },         
}),
})
