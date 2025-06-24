local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use {
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            require('plugins.theme')  -- Вынесем настройку темы в отдельный файл
        end
    }
    -- Менеджер плагинов
    use 'wbthomason/packer.nvim'
    
    -- Внешний вид
    use 'nvim-lualine/lualine.nvim'      -- Статусная строка
    use 'nvim-tree/nvim-web-devicons'    -- Иконки
    
    -- Навигация
    use 'nvim-tree/nvim-tree.lua'        -- Файловый менеджер
    use 'nvim-telescope/telescope.nvim'  -- Поиск файлов
    
    -- LSP и автодополнение
    use 'neovim/nvim-lspconfig'          -- Конфигурация LSP
    use 'hrsh7th/nvim-cmp'               -- Автодополнение
    use 'hrsh7th/cmp-nvim-lsp'           -- Источник LSP для cmp
    use 'L3MON4D3/LuaSnip'               -- Сниппеты
    
    -- Python-специфичные плагины
    use 'Vimjas/vim-python-pep8-indent'  -- Правильные отступы для Python
    use 'jeetsukumaran/vim-python-indent-black'  -- Совместимость с Black
    
    -- Дополнительные инструменты
    use 'tpope/vim-commentary'           -- Комментирование кода
    use 'tpope/vim-fugitive'            -- Интеграция с Git
    
    if packer_bootstrap then
        require('packer').sync()
    end
end)
