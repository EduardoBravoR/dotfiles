local o = vim.o
local opt = vim.opt
local cmd = vim.cmd

-- Appearance
opt.guicursor = ""
opt.termguicolors = true
opt.bg = "dark"
opt.signcolumn = "yes"
opt.cursorline = true
opt.updatetime = 50

-- Line Numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = true

-- Listchars
opt.list = true
opt.listchars = {
  space = "⋅",
  tab = "→ ",
  trail = "·",
  eol = "↴",
}

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Scrolling
opt.scrolloff = 5
opt.sidescrolloff = 5

-- Wrap
opt.wrap = false
opt.linebreak = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Command line
opt.showcmd = true
opt.showmode = false
opt.wildmenu = true
opt.wildmode = "longest:full,full"
opt.wildoptions = "pum"
opt.pumheight = 10

-- Buffers / Tabline
-- o.showtabline = 2

-- Mouse
opt.mouse = "a"

-- Folds & Files
opt.foldmethod = "manual"
opt.viewoptions = "folds,options,cursor,unix,slash"
opt.showmatch = true
cmd("filetype plugin indent on")
cmd("syntax on")

-- Others
opt.backspace:append({ "indent", "eol", "start" })
opt.iskeyword:append("-")
opt.gdefault = true
opt.laststatus = 3

