local which_key = require("which-key")

which_key.setup({
   key_labels = {
      ["<leader>"] = "LDR",
      ["<Space>"] = "SPC",
      ["<CR>"] = "RET",
      ["<Tab>"] = "TAB",
      ["<Esc>"] = "ESC",
   },
})

local normal_mappings = {
   ["<Leader>f"] = { name = "+Telescope 🔭" },
   ["<Leader>fb"] = { "<cmd>Telescope buffers<cr>", "Buffers" },
   ["<Leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find files" },
   ["<Leader>fg"] = { "<cmd>Telescope live_grep<cr>", "Live grep" },
   ["<Leader>fh"] = { "<cmd>Telescope help_tags<cr>", "Help tags" },
   ["<Leader>fm"] = { "<cmd>Telescope myles<cr>", "(Meta) Find files" },
   ["<Leader>fn"] = { "<cmd>Telescope notify<cr>", "Notifications" },
   ["<Leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Recent files" },
   ["<Leader>rn"] = { vim.lsp.buf.rename, "(LSP) Rename symbol" },
   ["<Leader>t"] = { name = "+Trouble 😈" },
   ["<Leader>tr"] = { "<cmd>TroubleRefresh<cr>", "Refresh Trouble" },
   ["<Leader>tt"] = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
   ["<Leader>u"] = { "<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>", "Toggle undo tree" },
   ["gD"] = { vim.lsp.buf.declaration, "(LSP) Go to declaration" },
   ["gd"] = { vim.lsp.buf.definition, "(LSP) Go to definition" },
   ["gi"] = { vim.lsp.buf.implementation, "(LSP) Go to implementation" },
   ["gr"] = { vim.lsp.buf.references, "(LSP) Go to references" },
}
which_key.register(normal_mappings, {})
