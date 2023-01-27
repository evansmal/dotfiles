-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

    use 'wbthomason/packer.nvim'

    use {'neoclide/coc.nvim', branch = 'release'}

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use 'aktersnurra/no-clown-fiesta.nvim'

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    use({
        'nvim-lualine/lualine.nvim',
        event = 'ColorScheme',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    })

    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-fugitive'

end)
