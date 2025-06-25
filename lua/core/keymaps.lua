-- Установка пробела как лидера
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Локальная переменная для удобства
local keymap = vim.keymap

-- Быстрое сохранение
keymap.set('n', '<leader>s', ':w<CR>', { desc = 'Save file' })

-- Поиск по файлу (используем Telescope)
keymap.set('n', '<leader>f', ':Telescope find_files<CR>', { desc = 'Find files' })

-- LSP-действия
keymap.set('n', '<leader>d', vim.lsp.buf.definition, { desc = 'Go to definition' })
keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = 'Rename symbol' })
-- Файловый менеджер
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>', { desc = 'Reveal current file in tree' })
-- Навигация между окнами
local function setup_window_navigation()
  local opts = { noremap = true, silent = true }

  -- Основные комбинации
  vim.keymap.set('n', '<leader>h', '<C-w>h', opts)
  vim.keymap.set('n', '<leader>j', '<C-w>j', opts)
  vim.keymap.set('n', '<leader>k', '<C-w>k', opts)
  vim.keymap.set('n', '<leader>l', '<C-w>l', opts)

  -- Дополнительные удобства
  vim.keymap.set('n', '<leader>H', '<C-w>H', opts) -- Переместить окно влево
  vim.keymap.set('n', '<leader>J', '<C-w>J', opts) -- Переместить окно вниз
  vim.keymap.set('n', '<leader>K', '<C-w>K', opts) -- Переместить окно вверх
  vim.keymap.set('n', '<leader>L', '<C-w>L', opts) -- Переместить окно вправо

  -- Быстрое закрытие окна
  vim.keymap.set('n', '<leader>q', '<C-w>c', opts)
end

setup_window_navigation()

-- Запуск Python-файла
keymap.set('n', '<leader>rp', ':w<CR>:!python3 %<CR>', { desc = 'Run Python file' })
