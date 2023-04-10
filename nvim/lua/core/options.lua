local opt = vim.opt
local cache_path = require("core.config").cache_path

if vim.fn.has "vim_starting" == 1 then
  opt.tabstop = 4
  opt.shiftwidth = 4
end
opt.encoding = "utf-8"
opt.expandtab = true
opt.shiftround = true
opt.smartindent = true
opt.smarttab = true

opt.clipboard = "unnamedplus"

opt.backspace = { "indent", "eol", "start" }

opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true
opt.incsearch = true

opt.cursorline = true

opt.number = true
opt.numberwidth = 4
opt.relativenumber = true
opt.signcolumn = "yes"

opt.showtabline = 2
opt.title = true
opt.titlelen = 80
opt.cmdheight = 2
opt.hidden = true

opt.updatetime = 250

opt.timeout = true
opt.timeoutlen = 1000
opt.ttimeout = true
opt.ttimeoutlen = 50

opt.splitbelow = true
opt.splitright = true

opt.autoread = true

opt.swapfile = true
opt.backup = false
opt.writebackup = false

opt.undofile = true
vim.g.undodir = cache_path .. "/undo"

opt.shortmess = "aTc"

opt.wildmenu = true
opt.wildmode = "full"
opt.wildoptions:append "pum"

opt.list = true
opt.listchars = { tab = ">·", nbsp = "+", trail = "·", extends = "→", precedes = "←" }

-- Disable tilde on blank area under EOF
opt.fcs:append "eob: "

-- Highlight embedded script (lua, python and ruby)
vim.g.vimsyn_embed = "lPr"

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false
