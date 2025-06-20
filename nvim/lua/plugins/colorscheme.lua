return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load before others
    lazy = false,    -- Load immediately at startup
    config = function()
        require("catppuccin").setup(
            {
                flavour = "macchiato", -- or "mocha", "latte", "frappe"
                transparent_background = false,
            }
        )
        vim.cmd.colorscheme("catppuccin")
    end
}
