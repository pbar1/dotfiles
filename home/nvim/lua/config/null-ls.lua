local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.nixpkgs_fmt,
		null_ls.builtins.code_actions.shellcheck,
		null_ls.builtins.diagnostics.statix,
	},
})
