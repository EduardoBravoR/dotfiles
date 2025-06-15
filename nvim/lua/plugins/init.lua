local ok, err = pcall(function()
  require("plugins.autopairs")
  require("plugins.blankline")
  require("plugins.colorizer")
  require("plugins.gitsigns")
  require("plugins.lualine")
  require("plugins.nvim-tree")
  require("plugins.telescope")
  require("plugins.treesitter")
end)

if not ok then
  vim.notify("Error loading plugins: " .. err, vim.log.levels.ERROR)
end
