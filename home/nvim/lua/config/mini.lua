local comment = require("mini.comment")
local pairs = require("mini.pairs")
local sessions = require("mini.sessions")

-- Enable autopairs
pairs.setup()

-- Enable commenting out lines with `gc` and `gcc`
comment.setup()

-- Enable automatic session saving/loading
local session_dir = vim.fn.stdpath("data") .. "/sessions"
if vim.fn.isdirectory(session_dir) == 0 then
   vim.fn.mkdir(session_dir, "p")
end
sessions.setup({
   autoread = false,
   directory = session_dir,
   file = "", -- Disable local sessions
})
