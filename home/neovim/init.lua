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
