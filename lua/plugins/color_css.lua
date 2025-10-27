require('colorizer').setup({
  'css',
  'scss', 
  'html',
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
  'django',
  'htmldjango',
  'jinja',
}, {
  mode = 'background',  -- Лучше для Tailwind
  css = true,
  css_fn = true,
  tailwind = true,  -- Включить поддержку Tailwind
  sass = { enable = true },
})
