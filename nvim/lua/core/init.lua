-- -- Use <Leader> for mappings of global plugin
vim.g.mapleader = " "
-- -- Use <LocalLeader> for mappings of filetype-local plugin
vim.g.maplocalleader = "z"
-- -- Release default mappings of the keys used for <Leader> and <LocalLeader>
vim.api.nvim_set_keymap("n", vim.g.mapleader, "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", vim.g.maplocalleader, "<Nop>", { noremap = true, silent = true })

-- Disable default plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

require "lib.packer".init()

vim.api.nvim_command "filetype plugin indent on"
if vim.fn.has "vim_starting" == 1 then
  vim.api.nvim_command "syntax enable"
end

require "core.options"
require "core.hack"
require("core.colorscheme").init()
require "core.keymap"
