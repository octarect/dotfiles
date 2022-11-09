local M = {}

M.runtime_path = vim.fn.expand "<sfile>:p:h"

if vim.env.XDG_CACHE_HOME then
  M.cache_path = vim.env.XDG_CACHE_HOME .. "/nvim"
else
  M.cache_path = "~/.cache/nvim"
end
M.cache_path = vim.fn.expand(M.cache_path)

return M
