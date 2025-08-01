local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')

  -- Основные хоткеи
  local function opts(desc)
    return { 
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true
    }
  end

  vim.keymap.set('n', '<CR>',    api.node.open.edit,        opts('Open')) 
  vim.keymap.set('n', 'o',       api.node.open.edit,        opts('Open'))
  vim.keymap.set('n', '<C-v>',   api.node.open.vertical,    opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>',   api.node.open.horizontal,  opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>',    api.node.navigate.parent_close, opts('Close Directory'))

  vim.keymap.set('n', 'a',       api.fs.create,             opts('Create'))
  vim.keymap.set('n', 'd',       api.fs.remove,             opts('Delete'))
  vim.keymap.set('n', 'r',       api.fs.rename,             opts('Rename'))
  vim.keymap.set('n', 'y',       api.fs.copy.node,          opts('Copy'))
  vim.keymap.set('n', 'p',       api.fs.paste,              opts('Paste'))
  vim.keymap.set('n', 'x',       api.fs.cut,                opts('Cut'))
end

require('nvim-tree').setup({
  -- Важные настройки:
  hijack_cursor = true,      -- Не терять курсор при открытии
  sync_root_with_cwd = true, -- Синхронизировать корень с CWD
  respect_buf_cwd = true,    -- Автообновление при смене директории

  -- Визуальные настройки:
  view = {
    adaptive_size = true,    -- Автоподстройка ширины
    number = true,
    relativenumber = true,
    signcolumn = 'yes',
    side = "right",
    centralize_selection = true,
  },

  renderer = {
    indent_markers = {
      enable = true,    -- Показать отступы
      inline_arrows = true,
      icons = {
        corner = "└",    -- Символ для угла
        edge = "│",      -- Символ для линии отступа
        item = "├",      -- Символ для элемента
        none = " ",       -- Пустой символ
      },
  },
  indent_width = 4, 
    icons = {
      webdev_colors = true,
      git_placement = 'after',
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true
      }
    }
  },

  -- Фильтры:
  filters = {
    custom = { '^\\.git$', '^\\.venv$' }  -- Скрыть .git
  },

  -- Системные интеграции:
  update_focused_file = {
    enable = true,           -- Автообновление при смене файла
    update_root = true
  },

  on_attach = my_on_attach   -- Наши кастомные хоткеи
})

-- Автоматические команды
vim.api.nvim_create_autocmd('BufEnter', {
  command = "if winnr('$') == 1 && &filetype == 'nvim-tree' | quit | endif",
  desc = 'Автозакрытие при последнем окне'
})
