require('nvim-treesitter.configs').setup({
  ensure_installed = {
    -- Бэкенд
    "python", "c", "lua", "vim", "bash",
    
    -- Фронтенд  
    "html", "css", "javascript", "json", "yaml",
  },

  highlight = { 
    enable = true,
    -- Дополнительные типы файлов для подсветки
    additional_vim_regex_highlighting = {"jinja", "django"}
  },
  
  indent = { enable = true },
})
