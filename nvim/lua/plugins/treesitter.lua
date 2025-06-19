local setup, treesitter = pcall(require, "nvim-treesitter.configs")

if not setup then
    return
end

treesitter.setup({
    ensure_installed = {
        "lua", "python", "javascript", "typescript", "html", "css",
        "bash", "json", "java"
    },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
})
