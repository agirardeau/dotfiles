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
      -- Define formatters
      formatters_by_ft = {
        -- These must be installed separately, either on the command line or
        -- through mason.nvim
        lua = { "stylua" },
        --python = { "isort", "black" },
        javascript = { "prettierd" },
        rust = { "rustfmt" },  -- Install with rustup rather than mason.nvim
      },
      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    config = function()
      -- Call mason to install 
      local mason = require("mason")
      mason.

    end,
  },

  {
    "zapling/mason-conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "stevearc/conform.nvim",
    },
    opts = {}  -- Nothing gets installed if this isn't present ¯\_(ツ)_/¯
    --opts = {
    --  ensure_installed = {
    --    "prettierd",  -- Javascript
    --    --"jsonnetfmt",  -- Jsonnet
    --    "stylua",  -- Lua
    --    --"isort",  -- Python
    --    --"black",  -- Python
    --  },
    --},
  },

  {
    -- Linter configuration
    "mfussenegger/nvim-lint",
    opts = {
      --events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      events = { "BufWritePost" },
      linters_by_ft = {
        -- These must be installed separately, either on the command line or
        -- through mason.nvim
        javascript = { 'quick-lint-js' },
        lua = { 'selene' },  -- `cargo install selene`
        -- TODO: install flake8 after updating to Ubuntu 2024.04 LTS and
        -- installing a newer python version.
        --python = { "flake8" },
        -- TODO: set up rust linting with clippy if possible
      },
    },
    config = function(_, opts)
      function debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      function lint()
        require("lint").try_lint()
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = debounce(100, lint),
      })
    end,
  },

  -- Note: This causes a bunch of weird stuff to get installed that isn't listed
  -- explicitly.
  -- TODO: Move away from these helper mason plugins and call mason directly to
  -- install packages.
  --{
  --  
  --  -- Install
  --  "rshkarin/mason-nvim-lint",
  --  dependencies = {
  --    "williamboman/mason.nvim",
  --    "mfussenegger/nvim-lint",
  --  },
  --  opts = {
  --    automatic_installation = true,
  --    --ensure_installed = {
  --    --  "quick-lint-js",  -- Javascript (consider eslint_d)
  --    --  "selene",  -- Lua (this throws an error, but `:MasonInstall selene` works fine?)
  --    --  -- TODO: install flake8 after updating to Ubuntu 2024.04 LTS and
  --    --  -- installing a newer python version.
  --    --  --"flake8",  -- Python
  --    --},
  --  },
  --}, 
}


