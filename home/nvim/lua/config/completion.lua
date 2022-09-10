local autopairs = require("nvim-autopairs")
local autopairs_cmp = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
local lspkind = require("lspkind")

autopairs.setup({})

cmp.event:on("confirm_done", autopairs_cmp.on_confirm_done())

cmp.setup({
   snippet = {
      expand = function(args)
         vim.fn["vsnip#anonymous"](args.body)
      end,
   },
   window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
   },
   mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = false }),
   }),
   sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "nvim_lsp_signature_help" },
      { name = "nvim_lua" },
      { name = "vsnip" },
      { name = "treesitter" },
      { name = "buffer" },
   }),
   formatting = {
      format = lspkind.cmp_format(),
   },
})
