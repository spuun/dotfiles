vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')

  use({
    'nvim-telescope/telescope.nvim', 
    branch = 'master',
    --tag = 'v0.1.9',
    requires = { {'nvim-lua/plenary.nvim'} }
  })

--  use({
--    "kelly-lin/telescope-ag",
--    requires = { "nvim-telescope/telescope.nvim" },
--  })

  -- colorscheme
  use({ 
    "rebelot/kanagawa.nvim",
    as = 'kanagawa'
  })

  use({
    'nvim-treesitter/nvim-treesitter',
    as = 'nvim-treesitter',
    run = ':TSUpdate',
    branch = 'main'
  })

  use({
    'vim-crystal/vim-crystal'
  })

  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  })

--  use({
--    'nvim-mini/mini.pick'
--  })

  use({
    "NeogitOrg/neogit",
    requires = {
      "nvim-lua/plenary.nvim",         -- required
      -- "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    }
  })
end)
