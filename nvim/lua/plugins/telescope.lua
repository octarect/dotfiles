-- Register a function wrapping a picker and return a vim command to invoke it.
local mapfuncs = {}
local function exec_picker(picker, dropdown)
  dropdown = dropdown or false
  mapfuncs[picker] = function()
    f = require('telescope.builtin')[picker]
    if dropdown then
      f(require('telescope.themes').get_dropdown())
    else
      f()
    end
  end
  return '<cmd>lua require("plugins.telescope").mapfuncs.' .. picker ..  '()<CR>'
end

local function set_keymaps()
  local buf_set_keymap = function(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', '<Leader>df', exec_picker('git_files'), opts)
  buf_set_keymap('n', '<Leader>dF', exec_picker('find_files'), opts)
  buf_set_keymap('n', '<Leader>dg', exec_picker('live_grep'), opts)
  buf_set_keymap('n', '<Leader>db', exec_picker('buffers'), opts)
  buf_set_keymap('n', '<Leader>dc', exec_picker('colorscheme', true), opts)
  -- telescope-symbols.nvim
  buf_set_keymap('n', '<Leader>de', exec_picker('symbols'), opts)
  -- nvim-treesitter
  buf_set_keymap('n', '<Leader>dj', exec_picker('treesitter'), opts)
end

local function init()
  local actions = require('telescope.actions')
  require('telescope').setup{
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
          ["<esc>"] = actions.close,
        },
      },
      winblend = 20,
      color_devicons = true,
    },
  }
end

return {
  set_keymaps = set_keymaps,
  init = init,
  mapfuncs = mapfuncs,
}
