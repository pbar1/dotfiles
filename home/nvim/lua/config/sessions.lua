local auto_session = require("auto-session")
-- TODO: session-lens

-- https://github.com/rmagatti/auto-session#recommended-sessionoptions-config
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- Ensure the session directory exists
local session_dir = vim.fn.stdpath("data") .. "/sessions"
if vim.fn.isdirectory(session_dir) == 0 then
   vim.fn.mkdir(session_dir, "p")
end

auto_session.setup({
   log_level = "error",
   auto_session_suppress_dirs = { "/", "~/", "~/code", "~/Downloads" },
})
