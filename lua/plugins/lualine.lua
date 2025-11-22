return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        icons_enable = true,
        theme = 'nordic',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '|', right = '|'},
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
    }
}
