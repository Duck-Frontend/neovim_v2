local keymap = vim.keymap

-- Основные комбинации
keymap.set('n', '<leader>pv', vim.cmd.Ex)  -- Открыть файловый менеджер

-- Перемещение между окнами
keymap.set('n', '<C-h>', '<C-w>h')
keymap.set('n', '<C-j>', '<C-w>j')
keymap.set('n', '<C-k>', '<C-w>k')
keymap.set('n', '<C-l>', '<C-w>l')

-- Python-специфичные комбинации
keymap.set('n', '<leader>rp', ':w<CR>:!python3 %<CR>')  -- Запуск текущего файла
