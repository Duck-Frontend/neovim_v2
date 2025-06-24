-- Дополнительные Python-специфичные настройки
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        -- Настройки форматирования
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.softtabstop = 4
        vim.bo.expandtab = true
        
        -- Автокоманды для Python
        vim.api.nvim_buf_set_keymap(0, 'n', '<leader>rp', ':w<CR>:!python %<CR>', {noremap = true})
    end
})
