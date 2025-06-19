-- Automatically install Packer
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

-- Auto-sync Packer on saving this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then return end

return packer.startup({
	function(use)
		-- Packer manages itself
		use("wbthomason/packer.nvim")

		-- Common dependencies
		use("nvim-lua/plenary.nvim")
		use("nvim-tree/nvim-web-devicons") -- used by multiple plugins

		-- Themes
		use("Shatur/neovim-ayu")
		use("bluz71/vim-nightfly-guicolors")
		use("ellisonleao/gruvbox.nvim")
		use("navarasu/onedark.nvim")
		use({ "catppuccin/nvim", as = "catppuccin" })

		-- UI Enhancements
		use("windwp/nvim-autopairs")
		use("lukas-reineke/indent-blankline.nvim")
		use("norcalli/nvim-colorizer.lua")
		use("lewis6991/gitsigns.nvim")
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "nvim-tree/nvim-web-devicons" },
		})

		-- File explorer
		use("nvim-tree/nvim-tree.lua")

		-- Fuzzy finding
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			requires = { "nvim-lua/plenary.nvim" },
		})

		-- Syntax highlighting
		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				require("nvim-treesitter.install").update({ with_sync = true })
			end,
		})

		-- Sync plugins if this is the first time installing
		if packer_bootstrap then
			require("packer").sync()
		end
	end,

	-- Floating window for packer
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
