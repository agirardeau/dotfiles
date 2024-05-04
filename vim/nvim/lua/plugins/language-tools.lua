return {
  {
    -- Formatter configuration
    "stevearc/conform.nvim",
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
    opts = {
      formatters_by_ft = require("data").formatter_names_by_filetype(),
      formatters = require("data").formatter_opts_by_name(),
    },
  },

  {
    -- Linter configuration
    "mfussenegger/nvim-lint",
    opts = {
      --events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      events = { "BufWritePost" },
      linters_by_ft = require("data").linter_names_by_filetype(),
    },
    config = function(_, opts)
      local function debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      local function lint()
        require("lint").try_lint()
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = debounce(100, lint),
      })
    end,
  },

  {
    -- Language server configuration
    'neovim/nvim-lspconfig',
    dependencies = { "folke/neodev.nvim" },
    config = function()
      for _, server in ipairs(require("data").language_servers()) do
        require("lspconfig")[server.name].setup(server.opts or {})
      end
    end,
  },

  {
    -- Debug adapter (DAP) configuration
    "rcarriga/nvim-dap-ui",
    dependencies = {
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
}
