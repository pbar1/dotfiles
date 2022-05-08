-- Enable Lua module caching if available
local ok, impatient = pcall(require, "impatient")
if ok then
	impatient.enable_profile()
end

-- Check if running in VS Code, used for conditional config
local not_vscode = function()
	return not vim.g.vscode
end

-------------------------------------------------------------------------------
-- Packer
-------------------------------------------------------------------------------

-- Bootstrap Packer
local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
	packer_bootstrap = vim.fn.system({
		"git",
		"clone",
		"--depth=1",
		"https://github.com/wbthomason/packer.nvim",
		packer_path,
	})
end

-- Load and configure Packer
vim.cmd("packadd packer.nvim")
local packer = require("packer")
packer.init({
	profile = {
		enable = true,
		threshold = 0,
	},
})

-- Load plugins
local use = packer.use

use({ "wbthomason/packer.nvim", opt = true })

use({ "dstein64/vim-startuptime", cond = not_vscode })

use({
	"nvim-telescope/telescope.nvim",
	cond = not_vscode,
	requires = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local themes = require("telescope.themes")

		telescope.setup({
			extensions = {
				["ui-select"] = {
					themes.get_dropdown({}),
				},
			},
		})

		telescope.load_extension("ui-select")
		telescope.load_extension("fzf")
	end,
})

-------------------------------------------------------------------------------
-- Vim Options
-------------------------------------------------------------------------------

-- Mouse support in all modes
vim.opt.mouse = "a"

-- Case-insensitive search, unless a capital letter is used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Share clipboard with system
vim.opt.clipboard:append("unnamedplus")

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])
