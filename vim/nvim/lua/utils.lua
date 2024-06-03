-- Adapted from github.com/nicknisi/dotfiles/blob/main/config/nvim/lua/utils.lua
local utils = {}

-- thanks to
-- https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/globals.lua
-- for inspiration
local function make_keymap_fn(mode, o)
  -- copy the opts table as extends will mutate opts
  local parent_opts = vim.deepcopy(o)
  return function(combo, mapping, opts)
    --assert(combo ~= mode, string.format("The combo should not be the same as the mode for %s", combo))
    local _opts = opts and vim.deepcopy(opts) or {}

    if type(mapping) == "function" then
      local fn_id = globals._create(mapping)
      mapping = string.format("<cmd>lua globals._execute(%s)<cr>", fn_id)
    end

    if _opts.bufnr then
      local bufnr = _opts.bufnr
      _opts.bufnr = nil
      _opts = vim.tbl_extend("keep", _opts, parent_opts)
      vim.api.nvim_buf_set_keymap(bufnr, mode, combo, mapping, _opts)
    else
      vim.api.nvim_set_keymap(mode, combo, mapping, vim.tbl_extend("keep", _opts, parent_opts))
    end
  end
end

local map_opts = {noremap = false, silent = true}
utils.map = make_keymap_fn("", map_opts)
utils.nmap = make_keymap_fn("n", map_opts)
utils.xmap = make_keymap_fn("x", map_opts)
utils.imap = make_keymap_fn("i", map_opts)
utils.vmap = make_keymap_fn("v", map_opts)
utils.omap = make_keymap_fn("o", map_opts)
utils.tmap = make_keymap_fn("t", map_opts)
utils.smap = make_keymap_fn("s", map_opts)
utils.cmap = make_keymap_fn("c", map_opts)

local noremap_opts = {noremap = true, silent = true}
utils.noremap = make_keymap_fn("", noremap_opts)
utils.nnoremap = make_keymap_fn("n", noremap_opts)
utils.xnoremap = make_keymap_fn("x", noremap_opts)
utils.vnoremap = make_keymap_fn("v", noremap_opts)
utils.inoremap = make_keymap_fn("i", noremap_opts)
utils.onoremap = make_keymap_fn("o", noremap_opts)
utils.tnoremap = make_keymap_fn("t", noremap_opts)
utils.cnoremap = make_keymap_fn("c", noremap_opts)

function utils.has_map(map, mode)
  mode = mode or "n"
  return vim.fn.maparg(map, mode) ~= ""
end

function utils.has_module(name)
  if
    pcall(
      function()
        require(name)
      end
    )
   then
    return true
  else
    return false
  end
end

function utils.termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function utils.file_exists(name)
  local f = io.open(name, "r")
  return f ~= nil and io.close(f)
end

function utils.has_active_lsp_client(servername)
  for _, client in pairs(vim.lsp.get_active_clients()) do
    if client.name == servername then
      return true
    end
  end
  return false
end

-- Filters a list of potential completions based on a prefix and return the
-- results sorted
function utils.filter_completions(completions, prefix)
  local ret = {}
  for _, comp in ipairs(completions) do
    if string.sub(comp, 1, string.len(prefix)) == prefix then
      table.insert(ret, comp)
    end
  end
  table.sort(ret)
  return ret
end

-- Return a debounced version of the provided function. When the returned
-- function is called, it schedules an execution in the future. Calling the
-- returned function again before the execution happens will have no effect.
function utils.debounce_first(ms, fn)
  local timer = vim.uv.new_timer()
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end

-- Return a debounced version of the provided function. When the returned
-- function is called, it cancels all previous executions, and schedules
-- a new execution in the future.
function utils.debounce_last(ms, fn)
  local timer = vim.uv.new_timer()
  return function(...)
    local argv = { ... }
    timer:stop()
    timer:start(ms, 0, function()
      vim.schedule_wrap(fn)(unpack(argv))
    end)
  end
end


return utils
