return
{
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            auto_install = true,
            ensure_installed = {
                "lua",
                "python",
                "javascript",
                "typescript",
                "html",
                "css",
                "json",
                "bash",
                "java"
            },
            highlight = {
                enable = true
            },
            indent = {
                enable = true
            }
        }
    end
}
