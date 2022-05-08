-------------------------------------------------------------------------------
-- Utilities
-------------------------------------------------------------------------------

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

-- 24-bit RGB color in TUI - uses "gui" highlights instead of "cterm"
vim.opt.termguicolors = true

-- Set font to be used in GUIs (Neovide, etc)
vim.opt.guifont = "Iosevka_Nerd_Font_Mono"

if not_vscode() then
	-- Highlight the current line
	vim.opt.cursorline = true
end

-------------------------------------------------------------------------------
-- Packer
-------------------------------------------------------------------------------

-- Bootstrap Packer if necessary
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

-- Initialize Packer
vim.cmd("packadd packer.nvim")
local packer = require("packer")
packer.init({
	profile = {
		enable = true,
		threshold = 0,
	},
})

-- Load plugins with Packer
local use = packer.use

use({ "wbthomason/packer.nvim", opt = true })

use({ "dstein64/vim-startuptime", cond = not_vscode })

use({
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate",
	cond = not_vscode,
	requires = { "lewis6991/spellsitter.nvim" },
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = { enable = true },
			indent = { enable = false }, -- Currently buggy in Go
			rainbow = { enable = false }, -- TODO: Integrate theme colors
		})
		require("nvim-treesitter.parsers").filetype_to_parsername.tf = "hcl"
		require("spellsitter").setup()
		vim.opt.spell = true
	end,
})

use({
	"sainnhe/gruvbox-material",
	cond = not_vscode,
	config = function()
		local gruvbox_pallete = "original"
		vim.g.gruvbox_material_palette = gruvbox_pallete
		vim.g.gruvbox_material_statusline_style = gruvbox_pallete
		vim.g.gruvbox_material_enable_bold = false
		vim.cmd("colorscheme gruvbox-material")
	end,
})

use({
	"nvim-lualine/lualine.nvim",
	cond = not_vscode,
	requires = { "kyazdani42/nvim-web-devicons", opt = true },
	config = function()
		require("lualine").setup({
			options = {
				theme = "gruvbox-material",
				component_separators = "|",
				section_separators = "",
				globalstatus = true,
			},
			sections = {
				lualine_b = {
					{ "branch", icon = "" },
				},
			},
		})
	end,
})

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
		telescope.setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})
		telescope.load_extension("ui-select")
		telescope.load_extension("fzf")
	end,
})
