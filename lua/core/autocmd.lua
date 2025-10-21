local autocmd = vim.api.nvim_create_autocmd


vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost init.lua source <afile> | PackerSync
  augroup end
]])

-- Автоформатирование при сохранении (опционально)
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = {'*.py', '*.js', '*.jsx', '*.ts', '*.tsx', '*.vue', '*.css', '*.scss', '*.html', '*.json' },
  callback = function()
    local clients = vim.lsp.get_active_clients()
    if #clients > 0 then
      vim.lsp.buf.format({ async = false })
    end
  end
})

