local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
})

require('mason-lspconfig').setup({
    ensure_installed = {
        "pyright",
        "html",
        "cssls",
    },
    automatic_installation = true,
})


local lspconfig = vim.lsp.config
lspconfig.pyright.setup({})



--local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }

    -- Навигация
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    
    -- Форматирование
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format({
            filter = function(client)
                return client.name == "null-ls" or client.name == "pyright"
            end,
            async = true
        })
    end, opts)

    -- Отключаем форматирование от LSP серверов (будет делать null-ls)
    if client.supports_method("textDocument/formatting") then
        client.server_capabilities.documentFormattingProvider = false 
    end
end

-- Конфигурации LSP серверов
local servers = {
    pyright = {
        settings = {
            pyright = {
                autoImportCompletion = true,
            },
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "off",
                    extraPaths = {"./venv/lib/python3.*/site-packages"},
                },
                formatting = {
                    provider = "black",
                }
            }
        }
    },
    html = {
        filetypes = {'html', 'htmldjango', 'jinja'},
    },
    cssls = {},
}

for server, config in pairs(servers) do
    config.capabilities = capabilities
    config.on_attach = on_attach
    -- lspconfig[server].setup(config)
end


-- Автокоманды для Django
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'python', 'htmldjango'},
    callback = function()
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4
    end
})
