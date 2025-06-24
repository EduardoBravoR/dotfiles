return {
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        }
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            ensure_installed = { "lua_ls", "jdtls" }
        }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.jdtls.setup({})
            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●", -- Change this to ">>", "✖", etc. if you like
                    spacing = 2,
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })
            -- Optional: Customize diagnostic text colors
            vim.cmd([[
                highlight DiagnosticVirtualTextError guifg=#FF6C6B
                highlight DiagnosticVirtualTextWarn guifg=#ECBE7B
                highlight DiagnosticVirtualTextInfo guifg=#51AFEF
                highlight DiagnosticVirtualTextHint guifg=#98BE65
            ]])
        end
    }
}
