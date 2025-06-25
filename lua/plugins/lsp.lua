local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')

-- Автоустановка LSP через Mason
mason_lspconfig.setup({
  ensure_installed = { "pylsp" },  -- или "pyright", "ruff_lsp"
})

-- Настройка LSP для Python
lspconfig.pylsp.setup({})  -- или lspconfig.pyright.setup({})

-- Доп. настройки (опционально)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name == 'pylsp' then
      -- Например, отключить предупреждения о неиспользуемых переменных
      client.config.settings = {
        pylsp = {
          plugins = {
            pycodestyle = { enabled = false },
            pylint = { enabled = true },
          }
        }
      }
      client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
    end
  end,
})
