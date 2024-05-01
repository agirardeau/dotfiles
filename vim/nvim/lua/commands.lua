local utils = require("utils")

vim.api.nvim_create_user_command(
  "AndrewMasonInstall",
  function(opts)
    -- If a filtype argument is provided, only search for configured packages
    -- for that filetype
    local configured_packages = require("data").mason_packages({
      filetype = opts.fargs[1],
    })
    local installed_packages = require("mason-registry").get_installed_package_names()
    local present_packages = {}
    local missing_packages = {}
    for _, pkg in ipairs(configured_packages) do
      if vim.list_contains(installed_packages, pkg) then
        table.insert(present_packages, pkg)
      else
        table.insert(missing_packages, pkg)
      end
    end
    if #missing_packages > 0 then
      vim.cmd("MasonInstall " .. table.concat(missing_packages, " "))
      vim.print("Installing new packages: " .. table.concat(missing_packages, ", "))
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
  "AndrewMasonClean",
  function(opts)
    local configured_packages = require("data").mason_packages({
      filetype = opts.fargs[1],
    })
    local installed_packages = require("mason-registry").get_installed_package_names()
    local extraneous_packages = {}
    for _, pkg in ipairs(installed_packages) do
      if not vim.list_contains(configured_packages, pkg) then
        table.insert(extraneous_packages, pkg)
      end
    end
    if #extraneous_packages > 0 then
      vim.cmd("MasonUninstall " .. table.concat(extraneous_packages, " "))
      vim.print("Removing extraneous packages: " .. table.concat(extraneous_packages, ", "))
    else
      vim.print("Mason packages are clean")
    end
  end,
  {
    desc = "Remove mason packages not declared in config",
  }
)

