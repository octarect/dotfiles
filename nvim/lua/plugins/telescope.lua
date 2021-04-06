local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        -- open files in horizontal by <C-s> instead of <C-x>
        ['<C-x>'] = false,
        ['<C-s>'] = actions.file_split,
      },
      n = {
        ["<esc>"] = actions.close,
      },
    },
    winblend = 20,
  },
}
