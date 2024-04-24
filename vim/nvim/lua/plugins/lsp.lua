return {
  -- Collection of common configurations for the Nvim LSP client
  {
    'neovim/nvim-lspconfig',
    -- Note: The dependency order is different for mason-lspconfig, which must
    -- run before nvim-lspconfig, and mason-conform or mason-nvim-list, which
    -- must run after conform and nvim-lint, respectively.
    -- Note: nvim-lspconfig has internal per-server configuration (e.g., mapping
    -- from file type to server name), so that data does not need to be provided
    -- (unlike for linters and formatters).
    -- TODO: Make this load lazily when a file with a configured lsp is opened.
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = true,
    opts = {
      ensure_installed = {
        -- These are referenced by executable name. Mapping from mason package
        -- name to executable name can be found at
        -- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md.
        "lua_ls",  -- Lua
        --"jsonnet_ls",  -- Jsonnet (go must be installed for mason to install this)
        "pyright",  -- Python (consider pylsp)
      },
    },
  },

}
