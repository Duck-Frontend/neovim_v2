local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- Python
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.diagnostics.flake8,
    
    -- Frontend Formatting
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript", "javascriptreact", "typescript", "typescriptreact",
        "vue", "css", "scss", "less", "html", "json", "jsonc",
        "yaml", "markdown", "graphql"
      },
      extra_args = { "--single-quote", "--jsx-single-quote" }
    }),
    
    -- Frontend Linting
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.stylelint,
    
    -- Code actions
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.code_actions.gitsigns,
    
    -- Shell/Docker
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shfmt,
  },
})

-- Keymaps для форматирования
vim.keymap.set('n', '<leader>ff', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', { desc = 'Format file' })
vim.keymap.set('n', '<leader>fp', '<cmd>Prettier<cr>', { desc = 'Prettier format' })
