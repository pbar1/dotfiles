local autopairs = require("nvim-autopairs")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local lspkind = require("lspkind")

autopairs.setup()

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
      -- If nothing explicitly selected, add newline, else select it
      -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr
      ["<CR>"] = cmp.mapping({
         i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
               cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
               fallback()
            end
         end,
         s = cmp.mapping.confirm({ select = true }),
         c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      }),
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

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
