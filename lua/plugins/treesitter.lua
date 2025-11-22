return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "html",
            "lua",
            "vim",
            "vimdoc",
            "htmldjango",
            "markdown",
            "markdown_inline",
            "javascript",
            "jinja",
            "jinja_inline",
            "json",
            "json5",
            "python",

        },
        autoinstall = true,
        highlight = {
            enable = true,
        },
        indent = {
            enable = true
        },
    },
}

