local on_filetype = require("lib.helper").on_filetype

local softtab_2sp = function()
  vim.bo.tabstop = 2
  vim.bo.shiftwidth = 2
end

local softtab_4sp = function()
  vim.bo.tabstop = 2
  vim.bo.shiftwidth = 2
end

local tab_4sp = function()
  vim.bo.tabstop = 4
  vim.bo.shiftwidth = 4
  vim.bo.expandtab = false
end

on_filetype("c", softtab_2sp)
on_filetype("cpp", softtab_2sp)
on_filetype("go", tab_4sp)
on_filetype("html", softtab_2sp)
on_filetype("javascript", softtab_2sp)
on_filetype("json", softtab_2sp)
on_filetype("lua", softtab_2sp)
on_filetype("make", tab_4sp)
on_filetype("python", softtab_4sp)
on_filetype("ruby", softtab_2sp)
on_filetype("toml", softtab_2sp)
on_filetype("typescript", softtab_2sp)
on_filetype("vim", softtab_2sp)
on_filetype("yaml", softtab_2sp)
on_filetype("markdown", softtab_2sp)
