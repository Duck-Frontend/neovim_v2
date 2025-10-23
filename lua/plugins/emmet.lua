vim.g.user_emmet_mode = 'a'                    -- Enable in all modes
vim.g.user_emmet_leader_key = '<C-e>'
vim.g.user_emmet_settings = {
    html = {
        extends = 'html',
        default_attributes = {
            option = { value = vim.null },
            textarea = {
                id = vim.null,
                name = vim.null,
                cols = 10,
                rows = 10
            }
        },
        snippets = {
            ['!'] = '<!DOCTYPE html>\n'
            .. '<html lang=\"en\">\n'
            .. '<head>\n'
            .. '\t<meta charset=\"UTF-8\">\n'
            .. '\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n'
            .. '\t<title>Document</title>\n'
            .. '</head>\n'
            .. '<body>\n\t${child}|\n</body>\n'
            .. '</html>',
        },
    },
    css = { extends = 'css' },
    javascript = { extends = 'jsx' },
    typescript = { extends = 'tsx' },
}
