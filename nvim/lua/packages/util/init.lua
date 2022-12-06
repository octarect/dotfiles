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
      "itchyny/vim-cursorword",
      event = { "BufNewFile", "BufRead" },
    },
    {
      "rainbowhxch/accelerated-jk.nvim",
      module = "accelerated-jk",
      setup = function()
        local keymap = require "lib.keymap"
        local accelerated_move = function(movement)
          return function() require("accelerated-jk").move_to(movement) end
        end
        keymap.nmap {
          { "j", accelerated_move "j", { keymap.flags.silent } },
          { "k", accelerated_move "k", { keymap.flags.silent } },
        }
      end,
    },
    {
      "norcalli/nvim-colorizer.lua",
      ft = { "css", "sass", "html", "javascript", "lua" },
      config = function()
        require("colorizer").setup {
          "css",
          "sass",
          "html",
          "javascript",
          "lua",
        }
      end,
    },
  },
}
