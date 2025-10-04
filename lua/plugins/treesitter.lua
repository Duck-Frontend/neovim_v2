require('nvim-treesitter.configs').setup({
  ensure_installed = {
    -- Бэкенд
    "python", "lua", "vim", "vimdoc", "c", "cpp",
    -- Фронтенд  
    "html", "css", "javascript", "typescript", "tsx", "jsx",
    "json", "yaml", "toml", "vue", "scss", "bash", "dockerfile"
  },
  
  highlight = { enable = true },
  indent = { enable = true },
  
  -- Дополнительные плагины Treesitter
  additional_vim_regex_highlighting = false,
  
  -- Автозакрывание тегов для HTML/JSX
  autotag = {
    enable = true,
    filetypes = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" }
  },
  
  -- Контекстное комментирование
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
})
