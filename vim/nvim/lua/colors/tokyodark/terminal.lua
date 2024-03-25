local p = require("colors.tokyodark.palette")

return {
  -- Each of these will be mapped to the `terminal_color_{n}` vim global variable.
  [0] = p.black,
  [8] = p.bg2,

  [7] = p.fg,
  [15] = p.fg,

  [1] = p.red,
  [9] = p.red,

  [2] = p.green,
  [10] = p.green,

  [3] = p.yellow,
  [11] = p.yellow,

  [4] = p.blue,
  [12] = p.blue,

  [5] = p.purple,
  [13] = p.purple,

  [6] = p.cyan,
  [14] = p.cyan,
}
