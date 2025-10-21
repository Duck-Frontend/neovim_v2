local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()


mason_lspconfig.setup({
  ensure_installed = {
    "pyright",        -- Python (лучше чем pylsp - быстрее и точнее)
    "clangd",         -- C/C++
    "html",           -- HTML
    "cssls",          -- CSS
    "tsserver",       -- JavaScript/TypeScript
    "jsonls",         -- JSON
    "yamlls",         -- YAML
    "bashls",         -- Bash scripts
  }
})

-- Python (Pyright - лучший для автодополнения)
lspconfig.pyright.setup({
  capabilities = capabilities,
})

-- C/C++
lspconfig.clangd.setup({
  capabilities = capabilities,
})

-- Frontend
lspconfig.html.setup({ capabilities = capabilities })
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({ capabilities = capabilities })

-- Конфиги
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.yamlls.setup({ capabilities = capabilities })

-- Bash
lspconfig.bashls.setup({ capabilities = capabilities })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr }

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    
    -- Форматирование через LSP или Prettier
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end
})
