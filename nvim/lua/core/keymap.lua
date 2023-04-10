local keymap = require "lib.keymap"
local nmap, vmap = keymap.nmap, keymap.vmap
local silent, noremap = keymap.flags.silent, keymap.flags.noremap
local flags = { silent, noremap }

local opt = vim.opt

nmap {
  { "[b", "<Cmd>bprevious<CR>", flags },
  { "]b", "<Cmd>bnext<CR>", flags },
  {
    "<F10>",
    function()
      local hlname = vim.api.nvim_exec("echo synIDattr(synID(line('.'), col('.'), 1), 'name')", true)
      print(hlname)
      print(vim.inspect(require("core.colorscheme").get_hl(hlname)))
    end,
    { noremap },
  },
  -- NOTE: What is this for ?
  { "M", "m", { noremap } },
  -- Turn on `public mode` to make my great editor readable by co-workers.
  {
    "<Leader>os",
    (function()
      local public_mode = false
      return function()
        if public_mode then
          -- Turn off
          public_mode = false
          opt.listchars = { tab = ">·", nbsp = "+", trail = "·", extends = "→", precedes = "←" }
          opt.relativenumber = true
        else
          -- Turn on
          public_mode = true
          opt.listchars = { tab = "  ", nbsp = "+", trail = "·", extends = "→", precedes = "←" }
          opt.relativenumber = false
        end
      end
    end)(),
    flags,
  },
}

vmap {
  { "<LocalLeader>r", "<Cmd>'<,'>w !bash<CR>", { noremap } },
}

-- Tab
local max_tab = 9
local tab_keymaps = {
  { "tc", "<Cmd>tabnew<CR>", flags },
  { "tq", "<Cmd>tabclose<CR>", flags },
  { "[t", "<Cmd>tabprev<CR>", flags },
  { "]t", "<Cmd>tabnext<CR>", flags },
}
for i = 1, max_tab do
  table.insert(tab_keymaps, {
    "t" .. i,
    "<Cmd>tabnext" .. i .. "<CR>",
    flags,
  })
end
nmap(tab_keymaps)

-- Folding
nmap {
  -- Open/Close fold recursively
  { "za", "zA", { noremap, silent }},
}
