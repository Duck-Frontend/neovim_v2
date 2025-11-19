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
    use 'wbthomason/packer.nvim'

    -- Тема
    use "gbprod/nord.nvim"
    use 'nvim-lualine/lualine.nvim'
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'

    -- Навигация
    use 'nvim-telescope/telescope.nvim'

    -- LSP и автодополнение
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'L3MON4D3/LuaSnip'

    -- Python и Django
    use 'nvim-treesitter/nvim-treesitter'
    use 'vim-scripts/django.vim'

    -- Форматтеры и линтеры
    use 'nvimtools/none-ls.nvim'


    

    -- Инструменты
    use 'tpope/vim-commentary'
    use 'windwp/nvim-autopairs'

    -- Зависимости для некоторых плагинов
    use "nvim-lua/plenary.nvim"

    if packer_bootstrap then
        require('packer').sync()
    end
end)
