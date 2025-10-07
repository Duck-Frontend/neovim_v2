local autocmd = vim.api.nvim_create_autocmd

-- Автоформатирование при сохранении для Python
autocmd('BufWritePre', {
    pattern = '*.py',
    callback = function()
        vim.lsp.buf.format()
    end
})

-- Автоматическое закрытие nvim-tree при открытии файла
autocmd('BufEnter', {
    pattern = '',
    command = 'if winnr(\'$\') == 1 && bufname() == \'NvimTree_\' . tabpagenr() | quit | endif'
})

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])
-- Автокоманды для фронтенд разработки
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'html', 'javascript', 'typescript', 'css', 'vue' },
  callback = function()
    -- Установка tab=2 пробела для фронтенда
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    
    -- УБЕРИТЕ эту строку - она вызывает ошибку
    -- vim.cmd('EmmetInstall')
  end
})

-- Автоформатирование при сохранении (опционально)
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.js', '*.jsx', '*.ts', '*.tsx', '*.vue', '*.css', '*.scss', '*.html', '*.json' },
  callback = function()
    local clients = vim.lsp.get_active_clients()
    if #clients > 0 then
      vim.lsp.buf.format({ async = false })
    end
  end
})
