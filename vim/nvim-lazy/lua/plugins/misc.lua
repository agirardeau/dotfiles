return {
  { "dstein64/vim-startuptime" },
  { "nvim-lua/plenary.nvim" },
  { "folke/which-key.nvim" },
  { "nvim-tree/nvim-web-devicons" },
  { "godlygeek/tabular" },
  { "editorconfig/editorconfig-vim" },
  { "907th/vim-auto-save" },
  { "chrisbra/Recover.vim" },  -- Adds a `diff` option for comparing swp files. Perhaps not necessary since vim-auto-save prevents most swp files.

  {
    -- Draw lines for each indent scope
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
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
        delay = 300,  -- ms
        animation = function() return 0 end
      },
      options = {
        try_as_border = true,
      },
      symbol = "│",
    },
  },


  --{
  --  "folke/persistence.nvim",
  --  opts = {
  --    options = vim.opt.sessionoptions:get()
  --  },
  --},
}

