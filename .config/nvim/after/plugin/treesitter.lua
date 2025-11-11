local ts = require('nvim-treesitter')
--ts.setup {
--  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
--  ensure_installed = { "javascript", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "yaml", "json" },
--
--  -- Install parsers synchronously (only applied to `ensure_installed`)
--  sync_install = false,
--
--  -- Automatically install missing parsers when entering buffer
--  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
--  auto_install = true,
--
--  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
--  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
--
--  highlight = {
--    enable = true,
--
--    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--    -- Using this option may slow down your editor, and you may see some duplicate highlights.
--    -- Instead of true it can also be a list of languages
--    additional_vim_regex_highlighting = false,
--  },
--}
--
--
ts.install(
  {
    'lua', 'vim', 'vimdoc', 'query',
    'markdown', 'markdown_inline',
    'json', 'yaml', 'javascript',
    'css'
  },
  -- Do not print summary, as this will run at startup always, all the time.
  { summary = false }
)
--):wait(300000)

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
        vim.treesitter.start() 
        return
      end
    end
  end
})


