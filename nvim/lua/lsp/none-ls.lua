return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- LUA
				null_ls.builtins.formatting.stylua,
				-- Markdown
				-- 📦 Formatter: Prettier
				null_ls.builtins.formatting.prettier.with({
					filetypes = { "markdown", "html", "javascript", "typescript", "css", "json" },
				}),
				-- 🔍 Diagnostics: markdownlint
				null_ls.builtins.diagnostics.markdownlint.with({
					filetypes = { "markdown" },
				}),
				-- 🧠 Spell check with cspell
				-- null_ls.builtins.diagnostics.cspell.with({
				--     filetypes = { "markdown" },
				--     extra_args = { "--language", "en" },
				-- }),
			},
		})
	end,
}
