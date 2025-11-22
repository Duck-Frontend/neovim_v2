return {
    "nvimtools/none-ls.nvim",
    opts = {
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,    -- Lua
                    null_ls.builtins.formatting.black,     -- Python
                    null_ls.builtins.formatting.isort,     -- Python
                    null_ls.builtins.formatting.prettier,  -- JS/TS/HTML/CSS
                    null_ls.builtins.diagnostics.eslint_d, -- JavaScript/TypeScript
                    null_ls.builtins.diagnostics.flake8,   -- Python
                },
                on_attach = function(client, bufnr)
                if client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                    buffer = bufnr,
                    callback = function()
                    vim.lsp.buf.format({ async = false })
                end
            })
            end
        end
        ,})
    end
}
}
