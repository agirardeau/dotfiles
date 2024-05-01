return {
  {
    -- Formatter configuration
    "stevearc/conform.nvim",
    dependencies = { "williamboman/mason.nvim" },  -- Add mason as a dependency so that 
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
}
