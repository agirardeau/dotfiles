rust_tools = require('rust-tools')

rust_tools.setup({
  tools = { -- rust-tools options
    --autoSetHints = true, -- no longer used?
    --hover_with_actions = true,  -- deprecated, suggested to set keybind to :RustHoverActions in on_attach instead
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
})
