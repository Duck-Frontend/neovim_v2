vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local current_ft = vim.bo.filetype
    
    -- Закрыть NvimTree если открыт обычный файл (не дерево и не специальный буфер)
    if current_ft ~= 'nvim-tree' and current_ft ~= '' then
      local tree_wins = {}
      
      -- Найти все окна с nvim-tree
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local buf_ft = vim.api.nvim_buf_get_option(buf, 'filetype')
        if buf_ft == 'nvim-tree' then
          table.insert(tree_wins, win)
        end
      end
      
      -- Закрыть дерево если оно не в единственном окне
      if #tree_wins > 0 and #vim.api.nvim_list_wins() > 1 then
        for _, win in ipairs(tree_wins) do
          vim.api.nvim_win_close(win, true)
        end
      end
    end
  end,
  desc = 'Автозакрытие NvimTree при открытии файла'
})
