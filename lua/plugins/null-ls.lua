local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- Python форматирование
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,

    -- Frontend форматирование (если Prettier установлен)
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript", "javascriptreact", 
        "html", "css", "json", "yaml", "markdown"
      },
    }),
  },
})


vim.keymap.set('n', '<leader>f', function()
  vim.lsp.buf.format({ async = true })
end, { desc = 'Format file' })
