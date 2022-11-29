local config = require "core.config"

local uv = vim.loop
local packer = nil

local data_path = vim.fn.stdpath "data" .. "/site"
local packer_path = data_path .. "/pack/packer/opt/packer.nvim"
local packer_compiled_path = data_path .. "/plugin/packer_compiled.lua"
local packer_deps_path = data_path .. "/lua/packer_deps.lua"
local plugin_def_paths = { config.runtime_path .. "/lua/packages" }

local Dependencies = (function()
  local Dependencies = {}

  Dependencies.data = {}

  local get_plugin_name = function(plugin) return string.match(plugin[1], "/(.+)$") end

  Dependencies.push = function(plugin)
    local name = get_plugin_name(plugin)
    Dependencies.data[name] = {}
    for _, dep in ipairs(plugin.requires or {}) do
      local dep_name = get_plugin_name(dep)
      Dependencies.data[name][dep_name] = true
      if dep.requires ~= nil and #dep.requires > 0 then
        Dependencies.push(dep)
      end
    end
  end

  Dependencies.clear = function() Dependencies.plugins = {} end

  Dependencies.save = function(path)
    local script = string.format("return vim.fn.json_decode('%s')", vim.fn.json_encode(Dependencies.data))

    local parent_dir = string.match(path, "^(.+)/(.+)/?$")
    if not uv.fs_stat(parent_dir) then
      os.execute("mkdir -p " .. parent_dir)
    end

    local f = io.open(path, "w+")
    if f ~= nil then
      f:write(script)
      f:close()
    else
      error("Failed to open " .. path)
    end
  end

  return Dependencies
end)()

local Registerer = (function()
  local Registerer = {}

  -- NOTE: You cannot use a local variable in this function (error like `attempt call upvalue`)
  local load_dependencies = function(plugin_name)
    local plugin = require("packer_deps")[plugin_name]
    if not plugin then
      return
    end

    local dependencies = {}
    for dependency_name, _ in pairs(plugin or {}) do
      dependencies[#dependencies + 1] = dependency_name
    end

    require("packer").loader(unpack(dependencies))
  end

  local optimize_plugin
  optimize_plugin = function(plugin)
    if plugin.requires and #plugin.requires > 0 then
      -- Load dependencies automatically
      if plugin.config then
        plugin.config = { load_dependencies, plugin.config }
      elseif plugin.setup then
        plugin.setup = { load_dependencies, plugin.setup }
      else
        plugin.config = { load_dependencies }
      end

      for _, dependency in ipairs(plugin.requires or {}) do
        -- Dependencies are optional by default.
        if dependency.opt == nil then
          dependency.opt = true
        end

        optimize_plugin(dependency)
      end
    end
  end

  Registerer.register = function(opts)
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

      optimize_plugin(plugin)

      -- Save a plugin definition to resolve dependencies later
      Dependencies.push(plugin)

      packer.use(plugin)
    end
  end

  return Registerer
end)()

local init = function()
  if not uv.fs_stat(packer_path) then
    os.execute("git clone --depth 1 https://github.com/wbthomason/packer.nvim " .. packer_path)
  end

  if not packer then
    vim.api.nvim_command "packadd packer.nvim"
    packer = require "packer"
  end

  packer.init {
    compile_path = packer_compiled_path,
    disable_commands = true,
    display = {
      open_fn = function()
        local result, win, buf = require("packer.util").float(config.window)
        vim.api.nvim_win_set_option(win, "winhighlight", "NormalFloat:Normal")
        return result, win, buf
      end,
    },
  }
  packer.reset()
  packer.use { "wbthomason/packer.nvim", opt = true }

  -- Reload plugin definitions
  Dependencies.clear()
  for _, path in ipairs(plugin_def_paths) do
    local module_paths = vim.split(vim.fn.globpath(path, "**/init.lua"), "\n")
    for _, module_path in ipairs(module_paths) do
      local module_name = string.match(module_path, "lua/(.+)/init%.lua$")

      if package.loaded[module_name] ~= nil then
        package.loaded[module_name] = nil
      end
      require(module_name)
    end
  end
end

local M = setmetatable({}, {
  __index = function(_, key)
    init()
    if key == "sync" then
      Dependencies.save(packer_deps_path)
    end
    return packer[key]
  end,
})

M.register = Registerer.register

local aug = vim.api.nvim_create_augroup("MyAutoCmdPacker", {})
vim.api.nvim_create_autocmd({ "User" }, {
  group = aug,
  pattern = "PackerCompileDone",
  callback = function()
    vim.notify("Compile done!!", vim.log.levels.INFO, { title = "Packer" })
    dofile(vim.env.MYVIMRC)
  end,
})

-- TODO: define user command

return M
