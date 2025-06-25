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
