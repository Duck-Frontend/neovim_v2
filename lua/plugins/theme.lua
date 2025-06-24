-- lua/plugins/theme.lua

require("rose-pine").setup({
    variant = "main",  -- Явно указываем тёмный вариант
    dark_variant = "main",  -- Основной тёмный стиль
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    styles = {
        bold = true,
        italic = true,
        transparency = false,  -- Отключить прозрачность (для лучшей читаемости)
    },

    -- Дополнительные настройки (можно оставить как есть или адаптировать)
    groups = {
        border = "muted",
        panel = "surface",
        error = "love",
        hint = "iris",
        warn = "gold",
    },

    -- Отключить ненужные подсветки (опционально)
    highlight_groups = {
        StatusLine = { bg = "base", fg = "text" },
    }
})

-- Применить тему (тёмный вариант)
vim.cmd("colorscheme rose-pine")
