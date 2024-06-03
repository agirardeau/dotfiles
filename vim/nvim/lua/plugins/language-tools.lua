-- Predicate that returns true if a language tool is either in mason's list of
-- installed packages or is not mason managed
local function tool_installed_or_unmanaged(tool)
  return tool.mason_package == nil or vim.list_contains(
    require("mason-registry").get_installed_package_names(),
    tool.mason_package
  )
end

return {
  {
    -- Formatter configuration
    "stevearc/conform.nvim",
    dependencies = { "williamboman/mason.nvim" } ,
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>o",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    config = function()
      local conform = require("conform")
      local data = require("data")
      conform.formatters_by_ft = data.formatter_names_by_filetype({
        enabled = true,
        predicate = tool_installed_or_unmanaged,
      })
      conform.formatters = data.formatter_opts_by_name({
        enabled = true,
        predicate = tool_installed_or_unmanaged,
      })
    end,
  },

  {
    -- Linter configuration
    "mfussenegger/nvim-lint",
    dependencies = { "williamboman/mason.nvim" } ,
    opts = {
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      --events = { "BufWritePost" },
    },
    config = function(_, opts)
      require("lint").linters_by_ft = require("data").linter_names_by_filetype({
        enabled = true,
        predicate = tool_installed_or_unmanaged,
      })

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = require("utils").debounce_last(100, function()
          require("lint").try_lint()
        end),
      })
    end,
  },

  {
    -- Language server configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      "williamboman/mason.nvim",
      "folke/neodev.nvim",
    },
    config = function()
      local servers = require("data").language_servers({
        enabled = true,
        predicate = tool_installed_or_unmanaged,
      })
      for _, server in ipairs(servers) do
        require("lspconfig")[server.name].setup(server.opts or {})
      end
    end,
  },

  {
    -- Debug adapter (DAP) configuration
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },

  {
    -- Package management for external tools (formatters, linters, language
    -- servers, debug adapters, etc)
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },

  {
    -- Lua settings active for neovim plugin development only.
    -- Does stuff like tell the language server that `vim` is a global.
    "folke/neodev.nvim",
    opts = {
      -- Enable for vim configuration in dotfiles directory.
      override = function(root_dir, library)
        if root_dir:find("/home/andrew/dotfiles/vim", 1, true) == 1 then
          library.enabled = true
          library.plugins = true
        end
      end,
    },
  },

  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    -- Note: Tools like rust-analyzer and rustfmt should be installed with rustup
    -- instead of mason.nvim.
  },

  --{ "LhKipp/nvim-nu" },
  { "elkasztano/nushell-syntax-vim" },
}
