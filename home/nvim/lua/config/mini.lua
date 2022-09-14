local pairs = require("mini.pairs")
local comment = require("mini.comment")

-- Enable autopairs
pairs.setup()

-- Enable commenting out lines with `gc` and `gcc`
comment.setup()
