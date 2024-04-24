local indent_char = "│"

return {
  -- Common dependencies
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  -- Utilities
  { "dstein64/vim-startuptime" },
  { "folke/which-key.nvim" },
  { "godlygeek/tabular" },
  { "editorconfig/editorconfig-vim" },
  { "907th/vim-auto-save" },
  { "chrisbra/Recover.vim" },  -- Adds a `diff` option for comparing swp files. Perhaps not necessary since vim-auto-save prevents most swp files.
  { "echasnovski/mini.bufremove", version = "*" },
  { "echasnovski/mini.surround", version = "*" },
  { "echasnovski/mini.ai", version = "*" },

  {
    "echasnovski/mini.pairs",
    version = "*",
    opts = {
      mappings = {
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
      },
    },
  },

  {
    -- Draw lines for each indent scope
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = indent_char,
        tab_char = indent_char,
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },

  {
    -- Highlights the current indent scope
    "echasnovski/mini.indentscope",
    opts = {
      draw = {
        delay = 200,  -- ms
        animation = function() return 0 end
      },
      options = {
        try_as_border = true,
      },
      symbol = indent_char,
    },
  },

  {
    -- Install tools external to neovim, like formatters, linters, language
    -- servers, and DAP (debugger) daemons. Leveraged in other configuration
    -- files.
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },

  -- Session management
  --{
  --  "folke/persistence.nvim",
  --  opts = {
  --    options = vim.opt.sessionoptions:get()
  --  },
  --},
}

