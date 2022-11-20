local config = require "core.config"

local uv = vim.loop
local packer = nil

local data_path = vim.fn.stdpath("data") .. "/site"
local packer_path = data_path .. "/pack/packer/opt/packer.nvim"
local packer_compiled_path = data_path .. "/lua/packer_compiled.lua"
local plugin_def_paths = { config.runtime_path .. "/lua/packages" }

-- NOTE: You cannot use a local variable in this function (error like `attempt call upvalue`)
local load_dependencies = function(plugin_name)
  local plugin = _G.packer_registered_plugins[plugin_name]
  if not plugin then
    return
  end

  for _, dependency in ipairs(plugin.requires or {}) do
    local dependency_name = string.match(dependency[1], "/([^/]+)$")
    if not _G.packer_plugins[dependency_name].loaded then
      vim.api.nvim_command("packadd " .. dependency_name)
    end
  end
end

local M = {}

M.reload_plugin_list = function()
  for _, path in ipairs(plugin_def_paths) do
    local module_paths = vim.split(path .. "\n" .. vim.fn.globpath(path, "**/"), "\n")
    for _, module_path in ipairs(module_paths) do
      local module_name = string.match(module_path, "lua/(.+)$")

      if package.loaded[module_name] ~= nil then
        package.loaded[module_name] = nil
      end
      require(module_name)
    end
  end
end

M.init = function(opts)
  opts = opts or {}
  opts.reload = opts.reload or false

  if not uv.fs_stat(packer_path) then
    os.execute("git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. packer_path)
    opts.reload = true
  end

  if not uv.fs_stat(packer_compiled_path) then
    opts.reload = true
  end

  if not packer then
    vim.api.nvim_command("packadd packer.nvim")
    packer = require "packer"
  end

  packer.init {
    compile_path = packer_compiled_path,
  }
  packer.reset()
  packer.use({ "wbthomason/packer.nvim", opt = true })
  M.reload_plugin_list()
  if opts.reload then
    packer.sync()
  else
    require("packer_compiled")
  end
end

_G.packer_registered_plugins = {}

M.register = function(opts)
  opts = opts or {}

  local plugins = opts.plugins
  opts.plugins = nil

  for _, plugin in ipairs(plugins) do
    -- Apply default options
    for k, v in pairs(opts) do
      if plugin[k] == nil then
        plugin[k] = v
      end
    end

    if plugin.requires and #plugin.requires > 0 then
      -- Load dependencies automatically
      if plugin.config then
        plugin.config = { load_dependencies, plugin.config }
      elseif plugin.setup then
        plugin.setup = { load_dependencies, plugin.setup }
      else
        plugin.config = { load_dependencies }
      end

      -- Dependencies are optional by default.
      for _, dependency in ipairs(plugin.requires or {}) do
        dependency.opt = dependency.opt or true
      end
    end


    -- Save a plugin definition to resolve dependencies later
    local plugin_name = string.match(plugin[1], "/(.+)$")
    _G.packer_registered_plugins[plugin_name] = plugin

    packer.use(plugin)
  end

  return true
end

local aug = vim.api.nvim_create_augroup("MyAutoCmdPacker", {})
vim.api.nvim_create_autocmd({ "User" }, {
  group = aug,
  pattern = "PackerCompileDone",
  callback = function()
    vim.notify("Compile done!!", vim.log.levels.INFO, { title = "Packer" })
    dofile(vim.env.MYVIMRC)
  end
})

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   group = aug,
--   -- pattern = "**/packages/**/*.lua",
--   pattern = (function()
--     local patterns = {}
--     for _, path in ipairs(plugin_def_paths) do
--       patterns[#patterns+1] = path .. "/**init.lua"
--     end
--     return patterns
--   end)(),
--   callback = function()
--     M.init { reload = true }
--   end
-- })

return M
