local ts = require('nvim-treesitter')

ts.install(
  {
    'lua', 
    'vim', 
    'vimdoc',
    'query',
--    'markdown',
--    'markdown_inline',
  'json', 
--    'yaml',
--    'javascript',
--    'css'
  },
  -- Do not print summary, as this will run at startup always, all the time.
  { summary = false }
)

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

vim.treesitter.language.register("crystal", { "cr" })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*' },
  callback = function(ev) 
    local parsers = ts.get_available()
    for index, value in ipairs(parsers) do
      if value == ev.match then
        --print(string.format('event fired: %s', vim.inspect(ev)))
        pcall(vim.treesitter.start)
        return
      end
    end
  end
})


