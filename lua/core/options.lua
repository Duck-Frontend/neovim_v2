local opt = vim.opt
local g = vim.g

-- Основные настройки
opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false
opt.termguicolors = true
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.updatetime = 50
opt.completeopt = 'menuone,noselect'

-- Python настройки
g.python3_host_prog = vim.fn.exepath('python3')

-- Django настройки
g.django_projects = vim.fn.getcwd()

-- Диагностика
vim.diagnostic.config({
    virtual_text = {
        severity = vim.diagnostic.severity.ERROR
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Автокоманды для Python/Django
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'python', 'htmldjango'},
    callback = function()
        -- Автоформатирование при сохранении
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = 0,
            callback = function()
                if vim.bo.filetype == 'python' then
                    -- Можно добавить вызов black/isort здесь
                    vim.lsp.buf.format({ async = false })
                else
                    vim.lsp.buf.format({ async = false })
                end
            end
        })
    end
})
