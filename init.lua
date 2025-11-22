-- Настройки редактора
require('core.options')
require('core.keymaps')
require('core.autocmd')

<<<<<<< HEAD
-- Инициализация плагинов
require('plugins.init')
require('plugins.cmp')
require('plugins.lualine')
require('plugins.tree')
require('plugins.lsp')
require('plugins.null-ls')
=======
-- LSP
require('core.lsp')

-- Менеджер плагинов
require('config.lazy')


-- Плагины
require('plugins.mason')
require('plugins.colorscheme')
require('plugins.tree')
require('plugins.lualine')
require('plugins.treesitter')
require('plugins.cmp')
require('plugins.none-ls')
>>>>>>> fde4f3885e4731f1d78db4ec1c8da6ee57ccfb06
