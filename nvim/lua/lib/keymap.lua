local M = {}

M.flags = {
  noremap = "noremap",
  desc = "desc",
  nowait = "nowait",
  silent = "silent",
  script = "script",
  expr = "expr",
}

local set_keymaps = function(buffer, mode, keymaps)
  for _, m in ipairs(keymaps) do
    local opts = {}

    local lhs = m[1]

    local rhs = ""
    if type(m[2]) == "function" then
      opts.callback = m[2]
    else
      rhs = m[2]
    end

    for _, flag in ipairs(m[3] or {}) do
      if M.flags[flag] == nil then
        error("Invalid flag are specified: " .. flag)
      end
      opts[flag] = true
    end

    if buffer then
      vim.api.nvim_buf_set_keymap(0, mode, lhs, rhs, opts)
    else
      vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
    end
  end
end

M.map = function(keymaps) set_keymaps(false, "", keymaps) end
M.nmap = function(keymaps) set_keymaps(false, "n", keymaps) end
M.imap = function(keymaps) set_keymaps(false, "i", keymaps) end
M.vmap = function(keymaps) set_keymaps(false, "v", keymaps) end
M.xmap = function(keymaps) set_keymaps(false, "x", keymaps) end

M.bmap = function(keymaps) set_keymaps(true, "", keymaps) end
M.bnmap = function(keymaps) set_keymaps(true, "n", keymaps) end
M.bimap = function(keymaps) set_keymaps(true, "i", keymaps) end
M.bvmap = function(keymaps) set_keymaps(true, "v", keymaps) end
M.bxmap = function(keymaps) set_keymaps(true, "x", keymaps) end

return M
