local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Установка LSP серверов через Mason
mason_lspconfig.setup({
  ensure_installed = {
    "pylsp",        -- Python (альтернатива: "pyright")
    "clangd",       -- C/C++
    "rust_analyzer" -- Для Rust (опционально)
  }
})

-- Настройка pylsp (Python)
lspconfig.pylsp.setup({
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },  -- Отключаем pycodestyle
        pylint = { enabled = true },       -- Включаем pylint
        pyflakes = { enabled = true },      -- Включаем pyflakes
        jedi_completion = { enabled = true },
        rope_autoimport = { enabled = true }
      }
    }
  },
  on_attach = function(client, bufnr)
    -- Общие LSP keymaps могут быть здесь
  end
})

-- Настройка clangd (C/C++)
lspconfig.clangd.setup({
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm"
  },
  on_attach = function(client, bufnr)
    -- Специфичные для C++ keymaps
    vim.keymap.set('n', '<leader>lh', '<cmd>ClangdSwitchSourceHeader<cr>', { buffer = bufnr })
  end
})

-- Общий обработчик для LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    -- Общие keymaps для всех LSP
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    -- Динамическое обновление конфигурации (особенно для Python)
    if client.name == 'pylsp' then
      client.config.settings = {
        pylsp = {
          plugins = {
            pycodestyle = { enabled = false },
            pylint = { enabled = true }
          }
        }
      }
      client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
    end
  end
})
