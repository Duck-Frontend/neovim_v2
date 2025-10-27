require('nvim-treesitter.configs').setup({
  ensure_installed = {
    -- Бэкенд
    "python", "c", "lua", "vim", "bash",
    -- 🔥 Фронтенд  
    "html", "css", "scss", "javascript", "typescript",
    "tsx", "jsx", "json", "yaml", "markdown", "vue"
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {"jinja", "django", "htmldjango"}  -- Добавил htmldjango
  },

  indent = { enable = true },
  autotag = { 
    enable = true,
    filetypes = {
      "html", "javascript", "javascriptreact", "typescript", "typescriptreact",
      "django", "htmldjango", "jinja"  -- Добавил Django templates
    }
  },
})
