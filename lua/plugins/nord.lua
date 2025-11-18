require("nord").setup({
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  diff = { mode = "bg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
  borders = true,
  errors = { mode = "bg" }, -- Display mode for errors and diagnostics
  search = { theme = "vim" }, 
  styles = {
    keywords = {},
    functions = {},
    variables = {},

    bufferline = {
      current = {},
      modified = { italic = false },
    },

    lualine_bold = false,
},
  colorblind = {
    enable = false,
    preserve_background = false,
    severity = {
      protan = 0.0,
      deutan = 0.0,
      tritan = 0.0,
    },
  },
  on_colors = function(colors) end,
  on_highlights = function(highlights, colors) end,
})
