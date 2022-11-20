local packer = require "lib.packer"

packer.register {
  plugins = {
    {
      "nvim-treesitter/nvim-treesitter",
      config = function()
        require("packages.treesitter.treesitter")
      end,
      run = ":TSUpdate",
      event = { "BufNewFile", "BufRead" },
      requires = {
        { "p00f/nvim-ts-rainbow" },
      },
    },
  },
}
