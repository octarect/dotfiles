local M = {}

M.flags = {
  noremap = "noremap",
  desc = "desc",
  nowait = "nowait",
  silent = "silent",
  script = "script",
  expr = "expr",
}

local set_keymaps = function(mode, keymaps)
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

    vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
  end
end

M.map = function(keymaps) set_keymaps("", keymaps) end
M.nmap = function(keymaps) set_keymaps("n", keymaps) end
M.imap = function(keymaps) set_keymaps("i", keymaps) end
M.vmap = function(keymaps) set_keymaps("v", keymaps) end
M.xmap = function(keymaps) set_keymaps("x", keymaps) end

return M
