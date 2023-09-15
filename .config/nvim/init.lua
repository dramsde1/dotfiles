--append all other parts of the config, the required name is the name of the folder in the lua folder as the working director
--that folder should also have an init.lua file in it, its a way of organizing your config
--this top most init.lua will have require statemnts and lazy plugin declarations only
--find out why I need to have utils before adding all the other modules?
--vim.fn.stdpath how to print where the data folder is

local fn = vim.fn
--Map leader to space
vim.g.mapleader = " "
local execute = vim.api.nvim_command
require("color")
require("settings")
require("keybindings")

local lualine = require("plugins.lualine")
local telescope = require("plugins.telescope")

local lspconfig = require("lsp.lsp")
local mason = require("lsp.mason")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim" },
		opts = telescope,
		keys = {
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find file" },
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
		opts = lualine,
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	lspconfig,
	mason,
	{
		"mason-lspconfig.nvim",
		opts = {}
	},
    {
        "hrsh7th/nvim-cmp"
    }
})
