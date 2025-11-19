local null_ls = require("null-ls")
local builtins = null_ls.builtins

-- Универсальный поиск бинарника
local function find_bin(name)
    local candidates = {
        vim.fn.stdpath("data") .. "/mason/bin/" .. name,             -- Mason
        vim.env.VIRTUAL_ENV and (vim.env.VIRTUAL_ENV .. "/bin/" .. name) or nil, -- venv
        vim.fn.expand("~/.local/bin/" .. name),                      -- pipx
        "/opt/homebrew/bin/" .. name,                                -- macOS homebrew ARM
        "/usr/local/bin/" .. name,                                   -- macOS intel
        "/usr/bin/" .. name,                                         -- fallback
    }

    for _, path in ipairs(candidates) do
        if path and vim.fn.executable(path) == 1 then
            return path
        end
    end

    return nil
end

local black = find_bin("black")
local isort = find_bin("isort")
local djlint = find_bin("djlint")

local sources = {}

-- === PYTHON ===
if isort then
    table.insert(sources, builtins.formatting.isort.with({
        command = isort,
    }))
end

if black then
    table.insert(sources, builtins.formatting.black.with({
        command = black,
    }))
end

-- === DJANGO HTML ===
if djlint then
    table.insert(sources, builtins.diagnostics.djlint.with({
        command = djlint,
        filetypes = { "htmldjango", "html" }
    }))

    table.insert(sources, builtins.formatting.djlint.with({
        command = djlint,
        args = { "--reformat" },
        filetypes = { "htmldjango", "html" }
    }))
end

null_ls.setup({
    sources = sources,
})

-- Форматирование перед сохранением Python
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.py",
    callback = function()
        vim.lsp.buf.format({
            filter = function(client)
                return client.name == "null-ls"
            end,
            async = false
        })
    end
})

