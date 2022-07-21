local treesitter = require("nvim-treesitter.configs")
local parsers = require("nvim-treesitter.parsers")

treesitter.setup({
   highlight = { enable = not vim.g.vscode },
   indent = { enable = false },
   rainbow = { enable = false },
})

parsers.filetype_to_parsername.tf = "hcl"

-- https://github.com/sourcegraph/tree-sitter-jsonnet/issues/3
local parser_config = parsers.get_parser_configs()
parser_config.jsonnet = {
   install_info = {
      -- FIXME: Don't hardcode
      url = "~/code/tree-sitter-jsonnet",
      files = { "src/parser.c", "src/scanner.c" },
   },
}
parsers.filetype_to_parsername.libsonnet = "jsonnet"
