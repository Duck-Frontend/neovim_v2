local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local schemastore_ok, schemastore = pcall(require, 'schemastore')
if not schemastore_ok then
  print("Schemastore not installed. Install it for better JSON support")
end

-- Установка LSP серверов через Mason
mason_lspconfig.setup({
  ensure_installed = {
    -- Бэкенд
    "pylsp", "clangd", "pylint", "pyflakes",
    
    -- Фронтенд
    "tsserver", "html", "cssls", "emmet_ls", "jsonls", "eslint",
    "vue_language_server", "tailwindcss",
    
    -- Дополнительно для Django/Flask
    "dockerls", "yamlls", "bashls"
  }
})
-- Функция для автоматического определения venv
local function get_python_path()
  local venv_path = vim.fn.getcwd() .. '/.venv'
  if vim.fn.isdirectory(venv_path) == 1 then
    return venv_path .. '/bin/python'
  end
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

-- Настройка pylsp (Python) с поддержкой venv
lspconfig.pylsp.setup({
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },
        pylint = { enabled = true },
        pyflakes = { enabled = true },
        jedi_completion = { enabled = true },
        rope_autoimport = { enabled = true },
        jedi = {
          environment = get_python_path(),
          extra_paths = { "./src" },
        },
      },
    },
  },
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
  }
})

-- Фронтенд LSP серверы

-- TypeScript/JavaScript
lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- Отключаем tsserver форматирование, используем Prettier
    client.server_capabilities.documentFormattingProvider = false
  end
})

-- HTML
lspconfig.html.setup({
  capabilities = capabilities,
  filetypes = { 'html', 'erb', 'ejs' }
})

-- CSS
lspconfig.cssls.setup({
  capabilities = capabilities
})

-- Emmet LSP
lspconfig.emmet_ls.setup({
  capabilities = capabilities,
  filetypes = { 
    'html', 
    'typescriptreact', 
    'javascriptreact', 
    'css', 
    'sass', 
    'scss', 
    'less', 
    'vue' 
  }
})

-- JSON
lspconfig.jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true }
    }
  }
})

-- ESLint
lspconfig.eslint.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

-- Vue.js (если используете)
lspconfig.vue_language_server.setup({
  capabilities = capabilities
})

-- Tailwind CSS (опционально)
lspconfig.tailwindcss.setup({
  capabilities = capabilities
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
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)

    -- Форматирование (кроме tsserver)
    if client.name ~= 'tsserver' then
      vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    else
      -- Для TypeScript используем отдельное форматирование
      vim.keymap.set('n', '<leader>f', function()
        vim.cmd('Prettier')
      end, opts)
    end

    -- Специфичные keymaps для C++
    if client.name == 'clangd' then
      vim.keymap.set('n', '<leader>lh', '<cmd>ClangdSwitchSourceHeader<cr>', opts)
    end

    -- Динамическое обновление конфигурации для Python
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

-- Дополнительная настройка форматирования
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    -- Форматирование
    null_ls.builtins.formatting.prettier.with({
      filetypes = { 
        "javascript", 
        "javascriptreact", 
        "typescript", 
        "typescriptreact", 
        "vue", 
        "css", 
        "scss", 
        "less", 
        "html", 
        "json", 
        "yaml", 
        "markdown" 
      },
    }),
    
    -- Линтинг
    null_ls.builtins.diagnostics.eslint_d,
    
    -- Code actions
    null_ls.builtins.code_actions.eslint_d,
  },
})

-- Глобальное форматирование (для файлов без LSP)
vim.keymap.set('n', '<leader>F', function()
  vim.lsp.buf.format({ async = true })
end, { desc = 'Format file' })
