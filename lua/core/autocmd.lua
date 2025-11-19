-- Автообновление Packer
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Автоформатирование для Python
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.py',
  callback = function()
    vim.lsp.buf.format({
        filter = function(client)
            return client.name == "null-ls"
        end,
        async = false
    })
  end
})

-- Автоматическое определение типа файла для Django шаблонов
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = '*.html',
  callback = function()
    local line = vim.fn.getline(1)
    if string.find(line, '{%') or string.find(line, '{{') then
      vim.bo.filetype = 'htmldjango'
    end
  end
})
