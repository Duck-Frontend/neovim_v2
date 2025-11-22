<<<<<<< HEAD
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
=======
return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "html",
            "lua",
            "vim",
            "vimdoc",
            "htmldjango",
            "markdown",
            "markdown_inline",
            "javascript",
            "jinja",
            "jinja_inline",
            "json",
            "json5",
            "python",

        },
        autoinstall = true,
        highlight = {
            enable = true,
        },
        indent = {
            enable = true
        },
    },
}

>>>>>>> fde4f3885e4731f1d78db4ec1c8da6ee57ccfb06
