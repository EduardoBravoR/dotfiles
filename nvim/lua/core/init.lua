local ok, err = pcall(function()
  require("core.options")
  require("core.keymaps")
  require("core.theme")
  require("core.plugins")
end)

if not ok then
  vim.notify("Error loading core: " .. err, vim.log.levels.ERROR)
end
