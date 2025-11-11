local set = vim.opt

-- tab width
set.tabstop = 2
-- how to ident '>>'
set.shiftwidth = 2
-- replace tab with spaces
set.expandtab = true
-- show cursor position all the time
set.ruler = true
-- hilight curstor line
set.cursorline = true
--
set.autoindent = true
set.smartindent = true
-- show invisible chars
set.list = true
set.listchars = "eol:¬,tab:->,trail:~,extends:>,precedes:<,nbsp:¶"
-- no BOM
set.bomb = false

set.number = true
set.relativenumber = true

set.hlsearch = false
set.incsearch = true

vim.scrolloff = 8

vim.g.mapleader = " "

vim.g.crystal_auto_format = 1
vim.g.crystal_enable_completion = 0

-- disable mouse
set.mouse = ''

set.termguicolors = true
