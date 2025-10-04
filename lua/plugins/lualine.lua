require('lualine').setup({
  options = {
    theme = 'nord',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 
      {'diagnostics', 
        sources = {'nvim_diagnostic'},
        symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}
      }
    },
    lualine_c = {
      {'filename', 
        path = 1,  -- 0 = только имя, 1 = относительный путь, 2 = абсолютный путь
        symbols = {modified = '  ', readonly = '  ', unnamed = '[No Name]'}
      }
    },
    lualine_x = {
      'encoding',
      {'fileformat', symbols = {unix = '', dos = '', mac = ''}},
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})
