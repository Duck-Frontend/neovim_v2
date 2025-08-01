local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Установка LSP серверов через Mason
mason_lspconfig.setup({
  ensure_installed = {
    "pylsp",        -- Python (альтернатива: "pyright")
    "clangd",       -- C/C++
  }
})

-- Функция для автоматического определения venv
local function get_python_path()
  -- Проверяем наличие venv в корне проекта
  local venv_path = vim.fn.getcwd() .. '/venv'
  if vim.fn.isdirectory(venv_path) == 1 then
    return venv_path .. '/bin/python'  -- Linux/MacOS
    -- Для Windows: venv_path .. '\\Scripts\\python.exe'
  end
  -- Если venv нет, используем глобальный Python
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

-- Настройка pylsp (Python) с поддержкой venv
lspconfig.pylsp.setup({
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = { enabled = false },  -- Отключаем pycodestyle (если мешает)
        pylint = { enabled = true },        -- Включаем pylint
        pyflakes = { enabled = true },      -- Включаем pyflakes
        jedi_completion = { enabled = true },
        rope_autoimport = { enabled = true },
        jedi = {
          environment = get_python_path(),  -- Указываем путь к Python из venv
          extra_paths = { "./src" },       -- Доп. пути для импортов
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Ключевые маппинги для LSP
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true })
  end,
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
