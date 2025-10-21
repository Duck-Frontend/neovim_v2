local opt = vim.opt
local g = vim.g


-- Основные настройки
opt.number = true             -- Номера строк
opt.relativenumber = true     -- Относительные номера строк
opt.tabstop = 4               -- 1 таб = 4 пробела
opt.shiftwidth = 4            -- Сдвиг на 4 пробела
opt.expandtab = true          -- Преобразование табов в пробелы
opt.smartindent = true        -- Умные отступы
opt.wrap = false              -- Отключить перенос строк
opt.termguicolors = true      -- 24-битные цвета
opt.swapfile = false          -- Не использовать swap-файлы
opt.backup = false            -- Не создавать backup-файлы
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- Каталог для undo-файлов
opt.undofile = true           -- Сохранять историю изменений
opt.hlsearch = false          -- Подсветка результатов поиска
opt.incsearch = true          -- Инкрементальный поиск
opt.ignorecase = true         -- Игнорировать регистр при поиске
opt.smartcase = true          -- Учитывать регистр при наличии заглавных букв
opt.scrolloff = 8             -- Минимальное число строк над/под курсором
opt.signcolumn = "yes"        -- Всегда показывать колонку знаков
opt.updatetime = 50           -- Частота обновления (мс)
opt.completeopt = 'menuone,noselect'  -- Настройки автодополнения


-- Python-специфичные настройки
g.python3_host_prog = vim.fn.exepath('python3')  -- Использовать Python3
