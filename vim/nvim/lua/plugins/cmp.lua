return {
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local cmp = require('cmp')
      local defaults = require("cmp.config.default")()
      return {
        -- Enable LSP snippets
        --snippet = {
        --  expand = function(args)
        --      vim.fn["vsnip#anonymous"](args.body)
        --  end,
        --},
        auto_brackets = {}, -- configure any filetype to auto add brackets
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = {
          --['<C-p>'] = cmp.mapping.select_prev_item(),
          --['<C-n>'] = cmp.mapping.select_next_item(),
          -- Add tab support
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<S-CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        formatting = {
          format = function(_, item)
            local icons = require("constants").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          --{ name = 'vsnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
        sorting = defaults.sorting,
      }
    end,
  },
}
