vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use('wbthomason/packer.nvim')

  use({
    'nvim-telescope/telescope.nvim', 
    branch = 'master',
    requires = { {'nvim-lua/plenary.nvim'} }
  })

  use({
    "kelly-lin/telescope-ag",
    requires = { "nvim-telescope/telescope.nvim" },
  })

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

  use({
    'polarmutex/git-worktree.nvim',
    version = '^2',
    as='git-worktree'
  })

  use({
    "NeogitOrg/neogit",
    requires = {
      "nvim-lua/plenary.nvim",         -- required
      -- "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    }
  })
end)
