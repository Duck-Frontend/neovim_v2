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
  -- Менеджер плагинов
  use 'wbthomason/packer.nvim'  -- У вас была опечатка в имени (ubthomason -> wbthomason)

  -- Внешний вид
  use {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      require('plugins.theme')
    end
  }
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-tree/nvim-web-devicons'  -- У вас была опечатка (devisons -> devicons)

  -- Навигация
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-telescope/telescope.nvim'

  -- LSP и автодополнение
  use 'neovim/nvim-lspconfig'
  -- Добавляем Mason и связанные плагины:
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    after = { 'mason.nvim', 'nvim-lspconfig' },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { 'pyright', 'pylsp' }  -- Автоустановка LSP-серверов
      })
    end
  }
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'  -- У вас была опечатка (L3MON403 -> L3MON4D3)

  -- Python-специфичные плагины
  use 'Vimjas/vim-python-pep8-indent'  -- У вас была опечатка (Vinjas -> Vimjas)
  use 'jeetsukumaran/vim-python-indent-black'

  -- Дополнительные инструменты
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
