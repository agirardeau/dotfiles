local utils = require("utils")

vim.api.nvim_create_user_command(
  "AndrewMasonInstall",
  function(opts)
    -- If a filtype argument is provided, only search for configured packages
    -- for that filetype
    local filetype = opts.fargs[1]

    local installed_package_names = require("mason-registry").get_installed_package_names()
    local missing_package_names = require("data").mason_package_names({
      filetype = filetype,
      enabled = true,
      predicate = function(tool)
        return not vim.list_contains(installed_package_names, tool.mason_package) and (
          filetype == nil or filetype == tool.filetype
        )
      end,
    })

    if #missing_package_names > 0 then
      vim.cmd("MasonInstall " .. table.concat(missing_package_names, " "))
      vim.print("Installing new packages: " .. table.concat(missing_package_names, ", "))
    else
      vim.print("No new packages to install")
    end
  end,
  {
    nargs = "?",
    desc = "Add mason packages declared in config. Optionally specify a filetype.",
    complete = function(arg_lead, _, _)
      return utils.filter_completions(require("data").filetypes(), arg_lead)
    end,
  }
)

vim.api.nvim_create_user_command(
  "AndrewMasonStatus",
  function()
    local data = require("data")
    local installed_package_names = require("mason-registry").get_installed_package_names()
    for _, filetype in ipairs(data.filetypes()) do
      vim.print(string.upper(filetype))

      local tools = data.language_tools({
        filetype = filetype,
        sort = true,
      })
      for _, tool in ipairs(tools) do
        local status = "not_installed"
        if vim.list_contains(installed_package_names, tool.mason_package) then
          status = "installed"
        elseif tool.mason_package == nil then
          status = "unmanaged"
        end
        if not tool.enabled then
          status = status .. " + disabled"
        end

        vim.print(string.format("  %s (%s, %s)", tool.name, tool.category, status))
      end
      vim.print("")
    end

    local enabled_package_names = data.enabled_mason_package_names()
    local extraneous_package_names = vim.tbl_filter(function(pkg_name)
      return not vim.list_contains(enabled_package_names, pkg_name)
    end, installed_package_names)
    if #extraneous_package_names > 0 then
      vim.print("Installed mason packages to clean: " .. table.concat(
        extraneous_package_names,
        ", "
      ))
      vim.print("")
    end
  end,
  {
    desc = "Print status of configured language tools",
  }
)

vim.api.nvim_create_user_command(
  "AndrewMasonClean",
  function()
    local enabled_package_names = require("data").enabled_mason_package_names()
    local installed_package_names = require("mason-registry").get_installed_package_names()
    local extraneous_package_names = vim.tbl_filter(function(pkg_name)
      return not vim.list_contains(enabled_package_names, pkg_name)
    end, installed_package_names)

    if #extraneous_package_names > 0 then
      vim.cmd("MasonUninstall " .. table.concat(extraneous_package_names, " "))
      vim.print("Removing extraneous packages: " .. table.concat(extraneous_package_names, ", "))
    else
      vim.print("Mason packages are clean")
    end
  end,
  {
    desc = "Remove mason packages not declared in config",
  }
)

