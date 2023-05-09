local lualine = require("lualine")

lualine.setup({
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
      lualine_c = {
         "navic",
      },
   },
})
