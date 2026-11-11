local ts = require('nvim-treesitter')

-- Must exist before ts.install(), which fires TSUpdate to load parser specs.
vim.api.nvim_create_autocmd("User", {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter.parsers').crystal = {
      install_info = {
        url = 'https://github.com/crystal-lang-tools/tree-sitter-crystal',
        -- path = '<ts-crystal-install-path>', -- if you want to use a local version instead
        branch = "main",
        generate = false,
        generate_from_json = false,
        queries = 'queries/nvim'
      },
    }
  end,
})

ts.install(
  {
    'lua',
    'vim',
    'vimdoc',
    'query',
--    'markdown',
--    'markdown_inline',
    'json',
    'crystal',
--    'yaml',
--    'javascript',
--    'css'
  },
  -- Do not print summary, as this will run at startup always, all the time.
  { summary = false }
)

-- start() maps filetype to parser itself and errors if none is installed.
vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
})
