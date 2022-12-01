local packer = require "lib.packer"

packer.register {
  plugins = {
    {
      "itchyny/vim-parenmatch",
      setup = function()
        vim.g.loaded_matchparen = 1
        vim.g.parentmatch_highlight = 0
        vim.api.nvim_set_hl(0, "ParenMatch", { link = "MatchParen" })
      end,
    },
    {
      "rhysd/accelerated-jk",
      keys = {
        { "n", "<Plug>(accelerated_jk_gj)" },
        { "n", "<Plug>(accelerated_jk_gk)" },
      },
      setup = function()
        local keymap = require "lib.keymap"
        keymap.nmap {
          { "j", "<Plug>(accelerated_jk_gj)", { keymap.flags.silent } },
          { "k", "<Plug>(accelerated_jk_gk)", { keymap.flags.silent } },
        }
      end,
    },
    {
      "itchyny/vim-cursorword",
      event = { "BufNewFile", "BufRead" },
    },
  },
}
