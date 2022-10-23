local mapfuncs = {}
local mapfuncs_cnt = 0

-- Create a dedicated function for mapping, and return a command to call it.
-- @param picker_name Picker name. ex) "builtin/find_files"
-- @param opts Picker options. The following keys are added for this function;
-- theme: Pass theme function if you want to use a theme. Default is nil (no theme)
local function get_picker_cmd(picker_name, opts)
  opts = opts or {}

  local theme = opts.theme
  opts.theme = nil

  mapfuncs_cnt = mapfuncs_cnt + 1
  local i = mapfuncs_cnt

  mapfuncs[i] = function()
    -- NOTE: require the root module before loading its children (and trigger on_lua)
    if not(package.loaded["telescope"]) then
      require("telescope")
    end

    local picker
    local picker_paths = vim.split(picker_name, "/")

    if picker_paths[1] == "builtin" then
      picker = require("telescope.builtin")[picker_paths[2]]
    else
      picker = require("telescope").extensions[picker_paths[1]][picker_paths[2]]
    end

    if theme == nil then
      picker(opts)
    else
      picker(require("telescope.themes")["get_" .. theme](opts))
    end
  end

  return string.format('<cmd>lua require("plugins.telescope").mapfuncs[%d]()<CR>', i)
end

local function set_keymaps()
  local set_keymap = function(...) vim.api.nvim_set_keymap(...) end
  local opts = { noremap=true, silent=true }

  set_keymap("n", "<Leader>df", get_picker_cmd("builtin/git_files"), opts)
  set_keymap("n", "<Leader>dF", get_picker_cmd("builtin/find_files"), opts)
  set_keymap("n", "<Leader>dg", get_picker_cmd("builtin/live_grep"), opts)
  set_keymap("n", "<Leader>db", get_picker_cmd("builtin/buffers"), opts)
  set_keymap("n", "<Leader>dc", get_picker_cmd("builtin/colorscheme", { theme = "dropdown" }), opts)
  set_keymap("n", "<Leader>dj", get_picker_cmd("builtin/treesitter"), opts)
  -- telescope-symbols.nvim
  set_keymap("n", "<Leader>de", get_picker_cmd("builtin/symbols"), opts)
  -- telescope-menu.nvim
  set_keymap("n", "<Leader>dm", get_picker_cmd("menu/menu", { theme = "cursor" }), opts)
  set_keymap("n", "<Leader>d,", get_picker_cmd("menu/filetype", { theme = "cursor" }), opts)
end

local function init()
  local actions = require'telescope.actions'
  require'telescope'.setup{
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          -- Open file in horizontal by <C-s> instead of <C-x>
          ['<C-x>'] = false,
          ['<C-s>'] = actions.file_split,
          -- Open file in new tab. (Disable tmux prefix <C-t>)
          ['<C-t>'] = false,
        },
        n = {
          ['<esc>'] = actions.close,
          ['<space>'] = actions.toggle_selection,
        },
      },
      winblend = 20,
      borderchars = { '-', '|', '-', '|', '+', '+', '+', '+' },
      color_devicons = true,
    },
    pickers = {
      buffers = {
        mappings = {
          i = {
            ['<C-d>'] = actions.delete_buffer,
          },
          n = {
            ['<C-d>'] = actions.delete_buffer,
          },
        },
      }
    }
  }
end

return {
  set_keymaps = set_keymaps,
  init = init,
  mapfuncs = mapfuncs,
}
