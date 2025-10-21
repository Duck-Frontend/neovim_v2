local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Настройка Mason
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    "pyright", "clangd", "html", "cssls", 
    "jsonls", "yamlls", "bashls"
  }
})

-- Настройка LSP серверов
local lspconfig = require('lspconfig')

-- Python
lspconfig.pyright.setup({
  capabilities = capabilities,
})

-- Остальные серверы...
lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.html.setup({ capabilities = capabilities })
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.yamlls.setup({ capabilities = capabilities })
lspconfig.bashls.setup({ capabilities = capabilities })

-- Общие горячие клавиши для ВСЕХ LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }

    vim.keymap.set('n', 'gd', function()
      vim.lsp.buf.definition({ reuse_win = true })  -- Использовать существующие окна
    end, opts)

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    
    -- Форматирование
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end
})
