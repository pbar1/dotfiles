-- plugins - Doom nvim custom plugins
--
-- This file contains all the custom plugins that are not in Doom nvim but that
-- the user requires. All the available fields can be found here
-- https://github.com/wbthomason/packer.nvim#specifying-plugins
--
-- By example, for including a plugin with a dependency on telescope:
-- return {
--     {
--         'user/repository',
--         requires = { 'nvim-lua/telescope.nvim' },
--     },
-- }

return {
    {'cormacrelf/dark-notify', config = [[require('dark_notify').run()]] },
    {'ishan9299/nvim-solarized-lua'},
    {'Glench/Vim-Jinja2-Syntax'},
    {'phaazon/hop.nvim', branch = "v1", config = function() require("hop").setup() end}
}

