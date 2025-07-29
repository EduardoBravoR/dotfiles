return {
    {
        "mason-org/mason.nvim",
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            -- auto_install = true,
            ensure_installed = {
                -- Lua
                "lua_ls", -- Lua support
                -- Back-end
                "jdtls", -- Java support
                -- Front-end
                -- "angularls", -- Angular Language Server
                "ts_ls", -- TypeScript/JavaScript
                "html", -- HTML support
                "cssls", -- CSS support
                "jsonls", -- JSON support
                -- Markdown
                "marksman",
                -- Install manually prettier, eslint_d, markdownlint, cspell, stylua
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- local capabilities = require("blink.cmp").get_lsp_capabilities()
            local lspconfig = require("lspconfig")

            -- Import keymaps config
            local keymaps = require("config.keymaps") -- adjust path as needed

            -- Lua
            lspconfig.lua_ls.setup({
                -- capabilities = capabilities,
            })

            -- Back-end
            lspconfig.jdtls.setup({})

            -- Front-end
            -- Angular Language Server
            -- lspconfig.angularls.setup({
            --     on_attach = keymaps.on_attach,
            -- })
            -- TypeScript Server
            lspconfig.ts_ls.setup({
                on_attach = keymaps.on_attach,
            })
            -- Optional: JSON and HTML support
            lspconfig.html.setup({
                on_attach = keymaps.on_attach,
            })
            lspconfig.cssls.setup({
                on_attach = keymaps.on_attach,
            })
            lspconfig.jsonls.setup({
                on_attach = keymaps.on_attach,
            })

            -- Markdown
            lspconfig.marksman.setup({
                filetypes = { "markdown" },
            })

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
        end,
    },
}
