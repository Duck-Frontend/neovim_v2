local null_ls = require("null-ls")

vim.keymap.set('n', '<leader>f', function()
  vim.lsp.buf.format({ async = true })
end, { desc = 'Format file' })

null_ls.setup({
  sources = {
    -- Python форматирование
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,

    -- Frontend форматирование с поддержкой Tailwind
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript", "javascriptreact", "typescript", "typescriptreact",
        "html", "css", "scss", "json", "yaml", "markdown",
        "django", "htmldjango"  -- Добавляем Django templates
      },
      extra_args = { "--plugin", "prettier-plugin-tailwindcss" }
    }),
  },
})
