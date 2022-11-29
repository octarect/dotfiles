local M = {}

local filetype_aug = vim.api.nvim_create_augroup("MyAutoCmdOnFiletype", {})
M.on_filetype = function(filetype, f)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = filetype_aug,
    pattern = filetype,
    callback = f,
  })
end

return M
