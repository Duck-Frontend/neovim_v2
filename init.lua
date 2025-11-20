-- Настройки редактора
require('core.options')
require('core.keymaps')
require('core.autocmd')

-- LSP
require('core.lsp')

-- Менеджер плагинов
require('config.lazy')


-- Плагины
require('plugins.mason')
require('plugins.colorscheme')
require('plugins.tree')
require('plugins.lualine')
