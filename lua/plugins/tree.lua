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

  -- Функция для умного открытия (закрывает дерево только для файлов)
  local function smart_open()
    local node = api.tree.get_node_under_cursor()
    
    if node then
      if node.type == "file" then
        -- Для файлов: открыть и закрыть дерево
        api.node.open.edit()
        vim.defer_fn(function()
          api.tree.close()
        end, 10)
      else
        -- Для директорий: просто открыть/закрыть без закрытия дерева
        api.node.open.edit()
      end
    end
  end

  -- Функция для открытия в сплите (без закрытия дерева)
  local function open_vertical_keep()
    api.node.open.vertical()
  end

  local function open_horizontal_keep()
    api.node.open.horizontal()
  end

  -- Основные хоткеи с умным открытием
  vim.keymap.set('n', '<CR>', smart_open, opts('Open File/Directory'))
  vim.keymap.set('n', 'o', smart_open, opts('Open File/Directory'))
  vim.keymap.set('n', 'l', smart_open, opts('Open File/Directory'))

  -- Специальные хоткеи без автозакрытия
  vim.keymap.set('n', '<C-v>', open_vertical_keep, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', open_horizontal_keep, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 'v', open_vertical_keep, opts('Open: Vertical Split'))
  vim.keymap.set('n', 's', open_horizontal_keep, opts('Open: Horizontal Split'))

  -- Навигация по дереву
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))

  -- Операции с файлами
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))

  -- Дополнительные удобства
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close Tree'))
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

  actions = {
    open_file = {
      quit_on_open = false,  -- Не закрывать Neovim при открытии файла
      window_picker = {
        enable = true,       -- Позволяет выбрать окно для открытия
      }
    }
  },

  on_attach = my_on_attach   -- Наши кастомные хоткеи
})

-- Автоматические команды для дополнительного автозакрытия при открытии файлов
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local current_ft = vim.bo.filetype
    
    -- Закрыть NvimTree если открыт обычный файл (не дерево и не спциальный буфер)
    if current_ft ~= 'nvim-tree' and current_ft ~= '' then
      local tree_wins = {}
      
      -- Найти все окна с nvim-tree
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_get_option(buf, 'filetype') == 'nvim-tree' then
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

-- Резервное автозакрытие при последнем окне
vim.api.nvim_create_autocmd('BufEnter', {
  command = "if winnr('$') == 1 && &filetype == 'nvim-tree' | quit | endif",
  desc = 'Автозакрытие при последнем окне'
})
