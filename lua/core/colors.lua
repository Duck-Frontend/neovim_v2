-- Проверяем, установлен ли плагин
local status, dracula = pcall(require, 'dracula')
if not status then
  vim.notify('Dracula не установлен! Запусти :PackerSync')
  return
end

-- Настройка темы (опционально)
dracula.setup({
  transparent_bg = true,
  italic_comment = true,
})

-- Включение темы
vim.cmd.colorscheme('atlas')
