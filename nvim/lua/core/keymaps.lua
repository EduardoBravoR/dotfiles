-- Set leader key
vim.g.mapleader = " "

local keymap = vim.keymap.set
local cmd = vim.cmd

local opts = { noremap = true, silent = true }

-- Disable search highlight on <leader>n
keymap("n", "<leader>n", ":nohlsearch<CR>", opts)
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
    callback = function() vim.fn.setreg("/", "") end,
})

-- Save / Quit
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)

-- Select all
keymap("n", "<C-a>", "ggVG", opts)

-- Keep search terms centered
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = [[%s/\s\+$//e]]
})

-- Disable automatic comment on newline
vim.api.nvim_create_augroup("no_auto_comment", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = "no_auto_comment",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.hl.on_yank({
      higroup = "IncSearch", -- or use "Visual" or a custom highlight group
      timeout = 100,         -- duration in milliseconds
    })
  end,
})

-- Faster scrolling (use Ctrl+d/u for page, keep these for line scrolling)
keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)

-- Split management
keymap("n", "<leader>sh", ":split<CR>", opts)
keymap("n", "<leader>sv", ":vsplit<CR>", opts)
-- Close / Manage splits
keymap("n", "<leader>sc", ":close<CR>", opts)
keymap("n", "<leader>so", ":only<CR>", opts)
-- Navigate splits
-- keymap("n", "<C-e>", "<C-W>j", opts)
-- keymap("n", "<C-u>", "<C-W>k", opts)
-- keymap("n", "<C-n>", "<C-W>h", opts)
-- keymap("n", "<C-i>", "<C-W>l", opts)
-- Resize splits
-- keymap("n", "<C-Up>", ":resize +2<CR>", opts)
-- keymap("n", "<C-Down>", ":resize -2<CR>", opts)
-- keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
-- keymap("n", "<leader>=", "<C-w>=", opts) -- Equalize

-- Buffer navigation
keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bp", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bd<CR>", opts)
keymap("n", "<leader>ba", ":%bd<CR>", opts)

-- Reload current Lua file
-- keymap("n", "<leader>s", ":luafile %<CR>", opts)

-- Open terminal in horizontal split
keymap("n", "<leader>t", ":split | terminal<CR>i", opts)

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fc", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

-- Indentation in visual mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- LSP Formatting (optional, enable if LSP is configured)
-- keymap("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)

--- keymap('n', '<leader>s', ':source %<cr>', {noremap = true})
-- :luafile %<cr>

-- keymap('n', '<leader>t', ':6sp term://zsh<cr>i', { noremap = true, silent=true })

-- Surround code
-- ysw" insert
-- dsw" delete
-- csw" change

-- Replace with register
-- grw

-- Vim motions
-- Cursor movement
-- w - jump forwards to the start of a word
-- W - jump forwards to the start of a word (words can contain punctuation)
-- b - jump backwards to the start of a word
-- B - jump backwards to the start of a word (words can contain punctuation)

-- 0 - jump to the start of the line
-- _ - jump to the first non-blank character of the line
-- $ - jump to the end of the line

-- fx - jump to next occurrence of character x
-- tx - jump to before next occurrence of character x
-- Fx - jump to the previous occurrence of character x
-- Tx - jump to after previous occurrence of character x

-- gg - go to the first line of the document
-- G - go to the last line of the document

-- Editing
-- r - replace a single character. (n mode)
-- x - delete (cut) character. (n mode)
-- cw or ce - change (replace) to the end of the word. (i mode)
-- s - delete character and substitute text (same as cl) (i mode)

-- Repeat
-- ; - repeat previous f, t, F or T movement
-- , - repeat previous f, t, F or T movement, backwards

-- Insert mode
-- i - insert before the cursor
-- I - insert at the beginning of the line
-- a - insert (append) after the cursor
-- A - insert (append) at the end of the line
-- o - append (open) a new line below the current line
-- O - append (open) a new line above the current line

-- Combined motions for inside arround chars w, p, {, }, [, ], (, )
-- vi[char]     va[char]
-- yi[char]     ya[char]
-- di[char]     da[char]
-- ci[char]     ca[char]

-- Combined motions for horizontal movement
-- vf[char]     vt[char]
-- yf[char]     yt[char]
-- df[char]     dt[char]
-- cf[char]     ct[char]

-- Increment numbers
-- Ctrl + a
-- 0 => 1
-- 0 => 1
-- 0 => 1
-- g Ctrl + a
-- 0 => 1
-- 0 => 2
-- 0 => 3
