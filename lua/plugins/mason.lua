return {
  {
    "neovim/nvim-lspconfig"
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim"
    },
    opts = {
      ensure_installed = {
          "lua_ls",
          "pyright",
          "html",
          "cssls",
          "jsonls",
          "sqlls",
      }
    }
  }
}
