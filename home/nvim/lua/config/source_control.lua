local gitsigns = require("gitsigns")

-- Gitsigns for Git repos
gitsigns.setup({
   on_attach = function()
      vim.cmd("SignifyDisableAll")
   end,
})

-- Signify for non-Git repos
vim.g.signify_sign_add = "│"
vim.g.signify_sign_change = "│"
vim.g.signify_sign_change_delete = "~"
