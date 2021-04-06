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
