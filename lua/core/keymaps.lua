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

-- Запуск Python-файла
keymap.set('n', '<leader>rp', ':w<CR>:!python3 %<CR>', { desc = 'Run Python file' })
