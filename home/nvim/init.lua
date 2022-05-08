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

use({ "lewis6991/impatient.nvim" })

use({ "nvim-lua/plenary.nvim" })

use({ "dstein64/vim-startuptime", cond = not_vscode })

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
	"goolord/alpha-nvim",
	cond = not_vscode,
	config = function()
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = {
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣤⣶⣶⣶⣾⣿⣿⣿⣿⣷⣶⣶⣶⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⢀⣠⣾⣿⣿⣿⣿⡿⢿⣛⣭⣽⣶⣶⣿⣿⣿⣿⣿⣿⣶⣶⣯⣭⣛⡻⢿⣿⣿⣿⣿⣷⣤⡀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⡿⣛⣵⣾⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣷⣮⣛⢿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀",
			"⠀⠀⠀⣰⣿⣿⣿⣿⠟⣩⣾⠿⣿⣿⣿⠿⣛⣭⣷⣶⣿⣿⣿⣿⣿⣿⣶⣾⣭⣛⠿⣿⣿⣿⣿⣷⣌⠻⣿⣿⣿⣿⣆⠀⠀⠀",
			"⠀⠀⣼⣿⣿⣿⡿⢫⣾⠋⠠⠿⠿⣫⣵⣿⣿⣿⣿⣿⣿⡟⠋⠉⢉⣙⣻⣿⣿⣿⣿⣶⣝⠿⠟⠛⠿⣷⣝⢿⣿⣿⣿⣧⠀⠀",
			"⠀⣸⣿⣿⣿⡿⣱⣿⣿⡀⠀⠀⠀⢸⣿⣿⣿⣿⣿⡿⣟⠀⠀⠀⠀⣻⠿⣿⣿⣿⣿⣿⡇⠀⠀⠀⢠⡈⣿⣎⢿⣿⣿⣿⣧⠀",
			"⢠⣿⣿⣿⣿⢣⣿⣿⣿⣿⢆⣶⣶⣿⣿⣿⣿⢟⣵⣿⣿⣷⣶⣶⣾⣿⣿⣮⡻⣿⣿⣿⣿⣷⣶⡔⣿⣷⣿⣿⡜⣿⣿⣿⣿⡄",
			"⢸⣿⣿⣿⣿⢸⣿⣿⣿⡿⣸⣿⣿⣿⣿⣿⡏⣾⣿⣿⣿⡿⠛⠛⢿⣿⣿⣿⣿⡸⣿⣿⣿⣿⣿⣧⢻⣿⣿⣿⣇⣿⣿⣿⣿⡇",
			"⢸⣿⣿⣿⣿⢸⣿⣿⣿⣧⢻⣿⣿⡿⣿⣿⠏⠛⠿⣿⣿⣧⣀⣀⣼⣿⣿⠿⠛⠡⢿⣿⣿⣿⣿⡿⣸⣿⣿⣿⡟⣼⣿⣿⣿⡇",
			"⠸⣿⣿⣿⣿⡸⣿⣿⣿⣿⡼⣿⣿⣷⡈⠁⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣏⠀⠀⠀⠀⢻⣿⣿⣿⢇⣿⣿⣿⣿⢇⣿⣿⣿⣿⡇",
			"⠀⢻⣿⣿⣿⣧⢻⣿⣿⣿⣷⡝⣿⣿⣿⣶⣶⣶⣶⣯⣟⣛⣿⣿⣛⣻⣭⣶⣶⠆⣠⣾⣿⣿⢏⣾⣿⣿⣿⡟⣼⣿⣿⣿⡿⠀",
			"⠀⠈⢿⣿⣿⣿⣧⡻⣿⣿⣿⣿⣮⡻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢟⣵⣿⣿⣿⣿⢟⣼⣿⣿⣿⡿⠁⠀",
			"⠀⠀⠈⢻⣿⣿⣿⣿⣎⠻⣿⣿⣿⣿⣷⣭⣛⠿⣿⣿⣿⡿⠿⠿⢿⣿⣿⣿⠿⣟⣯⣶⣿⣿⣿⣿⠿⣣⣿⣿⣿⣿⡟⠁⠀⠀",
			"⠀⠀⠀⠀⠙⢿⣿⣿⣿⣿⣮⣛⢿⣿⣿⣿⣿⣿⣷⣶⣿⡀⠀⠀⠀⣽⣶⣾⣿⣿⣿⣿⣿⡿⣟⣵⣾⣿⣿⣿⡿⠋⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⣿⣷⣮⣽⣛⠿⢿⣿⣿⣭⣉⣀⣤⣾⣿⣿⣿⡿⠿⣛⣯⣵⣾⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣯⣭⣭⣽⣿⣶⣶⣿⣿⣿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠛⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
		}
		require("alpha").setup(dashboard.config)
	end,
})

use({
	"nvim-telescope/telescope.nvim",
	cond = not_vscode,
	requires = {
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

use({
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate",
	cond = not_vscode,
	requires = { "lewis6991/spellsitter.nvim" },
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = { enable = true },
			indent = { enable = false }, -- TODO: Enable when not buggy in Go
			rainbow = { enable = false }, -- TODO: Integrate theme colors
		})
		require("nvim-treesitter.parsers").filetype_to_parsername.tf = "hcl"
		require("spellsitter").setup()
		vim.opt.spell = true
	end,
})

use({
	"hrsh7th/nvim-cmp",
	cond = not_vscode,
	requires = {
		{ "hrsh7th/vim-vsnip" },
		{ "hrsh7th/cmp-vsnip" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-cmdline" },
		{ "onsails/lspkind.nvim" },
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				{ name = "vsnip" },
				{ name = "path" },
				{ name = "buffer" },
			}),
			format = require("lspkind").cmp_format({
				mode = "symbol_text",
			}),
		})
	end,
})

use({
	"neovim/nvim-lspconfig",
	cond = not_vscode,
	after = "cmp-nvim-lsp",
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
		local on_attach = function(client, bufnr)
			-- Disable LSP formatting in favor of null-ls
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end
		local servers = {
			"bashls",
			"gopls",
			"pyright",
			"rnix",
			"terraformls",
		}
		for _, server in pairs(servers) do
			lspconfig[server].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end
		lspconfig["sumneko_lua"].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = { enable = false },
				},
			},
		})
	end,
})

use({
	"jose-elias-alvarez/null-ls.nvim",
	cond = not_vscode,
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		null_ls.setup({
			sources = {
				null_ls.builtins.code_actions.shellcheck,
				null_ls.builtins.diagnostics.statix,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.formatting.nixpkgs_fmt,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.stylua,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})
	end,
})
