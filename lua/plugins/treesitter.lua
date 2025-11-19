require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "python",
    "lua",
    "vim",
    "bash",
    "html",
    "css",
    "javascript",
    "typescript",
    "json",
    "yaml",
    "markdown",
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {"htmldjango"}
  },

  indent = { 
    enable = true,
    disable = {"python"}  -- Отключаем treesitter indent для Python (лучше работает без него)
  },

  -- Контекстное комментирование
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
})

-- Дополнительные настройки для Python
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    -- Включение лучшего форматирования для Python
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
    vim.bo.smartindent = true
  end
})
