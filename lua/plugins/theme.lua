-- Установка цветовой схемы afterglow
vim.cmd([[colorscheme afterglow]])

-- Дополнительные настройки темы (если нужно)
local afterglow = require('afterglow')

afterglow.setup({
    -- Пример настроек (опционально)
    transparent = false, -- Прозрачный фон (true/false)
    italic = true,      -- Курсив для комментариев
    overrides = {        -- Переопределение цветов
        Comment = { fg = '#5C6370', italic = true },
    },
})

-- Настройки для Neovim (опционально)
vim.opt.termguicolors = true -- Включение true-цветов
vim.opt.background = 'dark'  -- Тёмная тема
