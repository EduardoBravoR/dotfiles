-- Disable search highlight when enter insert mode
vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
	callback = function()
		vim.fn.setreg("/", "")
	end,
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = [[%s/\s\+$//e]],
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
			timeout = 100, -- duration in milliseconds
		})
	end,
})

-- Spelling check
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "markdown",
--     callback = function()
--         vim.opt_local.spell = true
--         vim.opt_local.spelllang = { "en_us" }
--     end,
-- })

-- Autoformat on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.md", "*.html", "*.css", "*.ts", "*.js", "*.lua", "*.java" },
	callback = function(args)
		-- Check if any LSP client supports formatting for this buffer
		local clients = vim.lsp.get_active_clients({ bufnr = args.buf })
		for _, client in ipairs(clients) do
			if client.server_capabilities.documentFormattingProvider then
				vim.lsp.buf.format({ bufnr = args.buf, async = false })
				return
			end
		end
	end,
})
