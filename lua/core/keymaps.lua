-- Установка пробела как лидера
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local shortcut = vim.keymap.set

-- Быстрое сохранение файла
shortcut('n', '<leader>s', ':w<cr>', {desc='Save'})

-- Быстрое закрытие окна
shortcut('n', '<leader>q', ':wq<cr>', {desc='Exit with save'})

<<<<<<< HEAD
-- Быстрое сохранение
keymap.set('n', '<leader>s', ':w<CR>', { desc = 'Save file' })


-- LiveServer для верстки
-- vim.keymap.set('n', '<leader>ls', '<cmd>LiveServerStart<cr>')
-- vim.keymap.set('n', '<leader>lq', '<cmd>LiveServerStop<cr>')


-- Файловый менеджер
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree' })
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>', { desc = 'Reveal current file in tree' })

=======
-- Открытие/Закрытие файлового дерева
shortcut('n', '<leader>e', ':NvimTreeToggle<cr>', {desc='Neotree toggle'})
>>>>>>> fde4f3885e4731f1d78db4ec1c8da6ee57ccfb06

-- Навигация между окнами
local function setup_window_navigation()
  local opts = { noremap = true, silent = true }


  -- Основные комбинации
  shortcut('n', '<leader>h', '<C-w>h', opts)
  shortcut('n', '<leader>j', '<C-w>j', opts)
  shortcut('n', '<leader>k', '<C-w>k', opts)
  shortcut('n', '<leader>l', '<C-w>l', opts)


  -- Дополнительные удобства
  shortcut('n', '<leader>H', '<C-w>H', opts) -- Переместить окно влево
  shortcut('n', '<leader>J', '<C-w>J', opts) -- Переместить окно вниз
  shortcut('n', '<leader>K', '<C-w>K', opts) -- Переместить окно вверх
  shortcut('n', '<leader>L', '<C-w>L', opts) -- Переместить окно вправо

end


setup_window_navigation()
