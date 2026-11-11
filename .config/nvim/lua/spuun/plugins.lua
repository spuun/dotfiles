-- nvim-treesitter pins parser versions; rebuild them when it updates.
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local d = ev.data
    if d.spec.name == 'nvim-treesitter' and d.kind == 'update' then
      if not d.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  -- 'https://github.com/kelly-lin/telescope-ag',

  -- colorscheme
  'https://github.com/rebelot/kanagawa.nvim',

  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  'https://github.com/vim-crystal/vim-crystal',

  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',

  -- 'https://github.com/nvim-mini/mini.pick',

  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/NeogitOrg/neogit',
})
