local config = require "core.config"

-- Dark powered plugin management
vim.g["dein#install_max_processes"] = 16
vim.g["dein#enable_notification"] = 1
vim.g["dein#install_progress_type"] = "echo"
vim.g["dein#install_log_filename"] = config.cache_path .. "/dein.log"

local dein_path = config.cache_path .. "/dein"
local dein_repo_path = dein_path .. "/repos/github.com/Shougo/dein.vim"

if vim.fn.executable "git" ~= 1 then
  error "Could not install dein.vim. Please install git."
end

if vim.fn.isdirectory(dein_repo_path) == 0 then
  os.execute("git clone https://github.com/Shougo/dein.vim " .. dein_repo_path)
end

vim.api.nvim_command("set runtimepath^=" .. dein_repo_path)

if vim.fn["dein#load_state"](dein_path) ~= 1 then
  return
end

local dein_toml_paths = vim.fn.glob(config.runtime_path .. "/dein/*.toml", 1, 1)

-- Add local plugin list if exists
local local_toml_path = "~/.local/share/nvim/local/dein_local.toml"
if vim.fn.filereadable(local_toml_path) == 1 then
  table.insert(dein_toml_paths, local_toml_path)
end

vim.fn["dein#begin"](dein_path, dein_toml_paths)

for _, toml_path in ipairs(dein_toml_paths) do
  if string.match(toml_path, "lazy") then
    vim.fn["dein#load_toml"](toml_path, { lazy = 1 })
  else
    vim.fn["dein#load_toml"](toml_path, { lazy = 0 })
  end
end

vim.fn["dein#end"]()
vim.fn["dein#save_state"]()

if vim.fn.has "vim_starting" == 1 then
  if vim.fn["dein#check_install"]() > 0 then
    vim.fn["dein#install"]()
  end
else
  vim.fn["dein#call_hook"] "source"
  vim.fn["dein#call_hook"] "post_source"
end

vim.fn["dein#call_hook"] "source"
vim.fn["dein#call_hook"] "post_source"
