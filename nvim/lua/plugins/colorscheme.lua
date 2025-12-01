return -- Using Lazy
{
  "navarasu/onedark.nvim",
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('onedark').setup {
      style = 'dark'
    }
    require('onedark').load()
  end
}
-- return {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     priority = 1000, -- Load before others
--     lazy = false,    -- Load immediately at startup
--     config = function()
--         require("catppuccin").setup(
--             {
--                 flavour = "mocha", -- or "mocha", "latte", "frappe", "macchiato"
--                 transparent_background = false,
--             }
--         )
--         vim.cmd.colorscheme("catppuccin")
--     end
-- }
