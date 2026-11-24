local telescope = require("telescope")
local builtin = require('telescope.builtin')
local config = require("telescope.config")
local action_state = require('telescope.actions.state')
local state = require('telescope.state')

-- How long after closing a picker it reopens as it was.
local REMEMBER_MS = 5000

-- Kept here because Telescope's resume cache holds only the last closed picker.
local last_pickers = {}

-- Reopens the picker named `name` as it was closed: prompt, results and
-- selection. `open(opts)` starts it fresh when nothing recent is remembered.
local function resumable(name, open)
  return function()
    local last = last_pickers[name]
    local picker = last and last.picker
    if last and last.closed_at and vim.uv.now() - last.closed_at < REMEMBER_MS
        and picker.cache_picker.is_cached then
      local cached = state.get_global_key('cached_pickers') or {}
      for i = #cached, 1, -1 do
        if cached[i] == picker then table.remove(cached, i) end
      end
      table.insert(cached, 1, picker)
      state.set_global_key('cached_pickers', cached)
      builtin.resume({ cache_index = 1 })
      return
    end
    open({
      -- Also runs on resume, so this always tracks the newest picker.
      attach_mappings = function(prompt_bufnr)
        local last = { picker = action_state.get_current_picker(prompt_bufnr) }
        last_pickers[name] = last
        -- Telescope wipes the prompt buffer on every kind of close.
        vim.api.nvim_create_autocmd('BufWipeout', {
          buffer = prompt_bufnr,
          once = true,
          callback = function() last.closed_at = vim.uv.now() end,
        })
        return true
      end,
    })
  end
end

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
--vim.keymap.set('n', '<leader>ps', function()
--	builtin.grep_string({ search = vim.fn.input("Grep > ") });
--end)
vim.keymap.set('n', '<leader>rg', resumable('rg', builtin.live_grep), {})

vim.keymap.set('n', '<leader>rs', resumable('rs', function(opts)
  builtin.live_grep(vim.tbl_extend('force', opts, {search_dirs = {'src'}}))
end), {})
vim.keymap.set('n', '<leader>rt', resumable('rt', function(opts)
  builtin.live_grep(vim.tbl_extend('force', opts, {search_dirs = {'spec'}}))
end), {})


-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			--find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
		},
	},
})
