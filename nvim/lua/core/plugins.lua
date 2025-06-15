-- Automatically installation
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand to install missing, update or remove unused plugins in neovim whenever you save this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup({
	function(use)
        -- Packer can manage itself
        use("wbthomason/packer.nvim")

        -- Themes
        use("Shatur/neovim-ayu")
        use("bluz71/vim-nightfly-guicolors")
        use({ "ellisonleao/gruvbox.nvim" })
        use("navarasu/onedark.nvim")
        use({ "catppuccin/nvim", as = "catppuccin" })

        -- Complement for other plugins
        use("nvim-lua/plenary.nvim")

        -- Autocomplete parenthesis and brackets
        use("windwp/nvim-autopairs")

        -- Indent line
        use("lukas-reineke/indent-blankline.nvim")

        -- RGB, HEX colors
        use("norcalli/nvim-colorizer.lua")

        -- Icons
        use("kyazdani42/nvim-web-devicons")
        use 'nvim-tree/nvim-web-devicons'

        -- Info decorations
        use("lewis6991/gitsigns.nvim")

        -- Status line
        use({
        	"nvim-lualine/lualine.nvim",
        	requires = { "kyazdani42/nvim-web-devicons", opt = true },
        })

        -- File explorer
        use {
            'nvim-tree/nvim-tree.lua',
            requires = {
                'nvim-tree/nvim-web-devicons', -- optional
            },
        }

        -- Fuzzy finding
        use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- Dependency for better performance
        use({
            "nvim-telescope/telescope.nvim",
            tag = "0.1.8",
            requires = { { "nvim-lua/plenary.nvim" } },
        }) -- Fuzzy finder

        -- Syntax highlighting and colors
        use {
            'nvim-treesitter/nvim-treesitter',
            run = function()
                local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
                ts_update()
            end,
        }

        if packer_bootstrap then
			require("packer").sync()
		end
	end,
	-- To floating packer window
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
