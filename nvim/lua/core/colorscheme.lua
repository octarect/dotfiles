local config = require "core.config"
local KVStore = require "lib.kvstore"

-- Use KVStore for persistence of settings
local kvs = KVStore.new(config.cache_path .. "/kv2", "colorscheme")

-- Helpers
local hl = function(name, opts) vim.api.nvim_set_hl(0, name, opts) end
local link = function(name, link_to) vim.api.nvim_set_hl(0, name, { link = link_to }) end
local get_hl = function(name)
  local status, result = pcall(function() return vim.api.nvim_get_hl_by_name(name, true) end)
  if not status or result == nil then
    return {}
  end
  return result
end
local defined = function(name) return get_hl(name)[true] == nil end

-- Apply patches to colorscheme
local patch_colorscheme = function()
  -- Global settings
  hl("LineNr", { fg = "#efefef", ctermfg = 252 })
  hl("Whitespace", { fg = "#b0bec5", ctermfg = 96 })
  hl("VertSplit", { fg = "Black", ctermfg = "Black" })
  hl("SignColumn", { fg = "#ebdbb2", ctermfg = 187 })

  -- Remove background color of blank area (EndOfBuffer) under EOF
  if vim.fn.has "nvim" == 1 or vim.fn.has "patch-7.4.237" then
    hl("EndOfBuffer", {})
  end

  -- Highlight groups for gitgutter
  hl("GitGutterAdd", { fg = "#00e676", ctermfg = 2 })
  hl("GitGutterChange", { fg = "#ffc400", ctermfg = 3 })
  hl("GitGutterChangeDelete", { fg = "#ffc400", ctermfg = 3 })
  hl("GitGutterDelete", { fg = "#ff3d00", ctermfg = 1 })

  -- Built-in LSP
  hl("LspDiagnosticsSignError", { fg = "#fd8489", ctermfg = 210, bold = true })
  hl("LspDiagnosticsSignWarning", { fg = "#fedf81", ctermfg = 222, bold = true })
  hl("LspDiagnosticsSignInformation", { fg = "#a8d2eb", ctermfg = 153, bold = true })
  hl("LspDiagnosticsSignhlnt", { fg = "#a9dd9d", ctermfg = 150, bold = true })
  link("LspReferenceRead", "Search")
  link("LspReferenceText", "Search")
  link("LspReferenceWrite", "Search")

  -- Treesitter support
  if not defined "@text.diff.add" then
    link("@text.diff.add", "DiffAdd")
    link("@text.diff.delete", "DiffDelete")
    link("@attribute", "DiffChange")
  end

  -- Make border of floating window blend into the background
  link("FloatBorder", "Normal")
end

-- Enable 24-bit RGB color
if vim.fn.has "nvim" == 1 then
  vim.opt.termguicolors = true
end

-- Define event for colorscheme change to reset and cache it
-- @return bool It is always false. See :h nvim_create_autocmd()
local aug = vim.api.nvim_create_augroup("MyAutoCmdColorScheme", {})
vim.api.nvim_create_autocmd({ "ColorSchemePre" }, {
  group = aug,
  pattern = "*",
  command = "hi clear",
})
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  group = aug,
  pattern = "*",
  callback = function(opts)
    -- Cache colorscheme to restore it on launching neovim next time
    local colorscheme = opts.match
    if vim.fn.has "vim_starting" ~= 1 then
      kvs:write("current", colorscheme)
    end

    patch_colorscheme()

    return false
  end,
})

-- Initialize colorscheme
local colorscheme = kvs:read "current" or "desert"

vim.opt.background = "dark"
vim.api.nvim_command("colorscheme " .. colorscheme)

local M = {}

M.get_hl = get_hl

return M
