require("config.lazy")
require('leap').create_default_mappings()
require('flit').setup {
  keys = { f = 'f', F = 'F', t = 't', T = 'T' },
  -- A string like "nv", "nvo", "o", etc.
  labeled_modes = "v",
  clever_repeat = true,
  multiline = true,
  opts = {}
}

vim.opt.shiftwidth = 4
vim.cmd.colorscheme "catppuccin"
vim.cmd.set "relativenumber"
