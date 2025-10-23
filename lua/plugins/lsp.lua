local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Улучшенные возможности
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' }
}

-- Настройка Mason
require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('mason-lspconfig').setup({
    ensure_installed = {
        -- Бэкенд
        "pyright", "clangd", "lua_ls", "bashls",
        -- 🔥 Фронтенд
        "html", "cssls", "tsserver", "emmet_ls", "jsonls", "yamlls"
    },
    automatic_installation = true,
})

-- Настройка LSP серверов
local lspconfig = require('lspconfig')

-- Общие настройки для всех LSP
local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }

    -- Хоткеи
    vim.keymap.set('n', 'gd', function()
        vim.lsp.buf.definition({ reuse_win = true })
    end, opts)
    
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format({ async = true })
    end, opts)

    -- Emmet хоткеи только для HTML/CSS
    local ft = vim.bo.filetype
    if ft == 'html' or ft == 'css' or ft == 'javascriptreact' or ft == 'typescriptreact' then
        vim.keymap.set('i', '<C-e>', '<C-y>,', { buffer = bufnr, desc = 'Emmet expand' })
    end
end

-- Конфигурации конкретных серверов
local servers = {
    pyright = {},
    clangd = {},
    html = { 
        filetypes = {'html', 'jinja', 'javascriptreact', 'typescriptreact'},
        capabilities = capabilities,
    },
    cssls = {
        filetypes = {'css', 'scss', 'sass', 'less'},
        capabilities = capabilities,
    },
    tsserver = {
        filetypes = {'javascript', 'typescript', 'javascriptreact', 'typescriptreact'},
        capabilities = capabilities,
    },
    emmet_ls = {
        filetypes = { 
            'html', 'css', 'scss', 'sass', 'less', 
            'javascriptreact', 'typescriptreact', 'vue'
        },
        capabilities = capabilities,
    },
    jsonls = {},
    yamlls = {},
    bashls = {},
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = {'vim'} },
                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                telemetry = { enable = false },
            }
        }
    },
}

for server, config in pairs(servers) do
    lspconfig[server].setup(vim.tbl_deep_extend('force', {
        capabilities = capabilities,
        on_attach = on_attach,
    }, config))
end
