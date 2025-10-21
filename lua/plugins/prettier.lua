return function()
  require('prettier').setup({
    single_quote = true,
    trailing_comma = 'all',
    tab_width = 2,
    semi = true,
    use_tabs = false,
    filetypes = {
      "javascript",
      "javascriptreact", 
      "typescript",
      "typescriptreact",
      "html",
      "css",
      "json",
      "yaml",
      "markdown"
    }
  })
end
