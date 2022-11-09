-- Show cursorline only in current window
local cl_hooks = vim.api.nvim_create_augroup("CursorLineHooks", {})
vim.api.nvim_create_autocmd({ "WinEnter" }, {
  group = cl_hooks,
  pattern = "*",
  callback = function() vim.opt.cursorline = true end,
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
  group = cl_hooks,
  pattern = "*",
  callback = function() vim.opt.cursorline = false end,
})

-- Resize windows in editor when terminal's window is resized
local aug = vim.api.nvim_create_augroup("MyAutoCmd", {})
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = aug,
  pattern = "*",
  command = "wincmd =",
})
