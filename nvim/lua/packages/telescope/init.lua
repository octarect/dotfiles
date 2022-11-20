local packer = require "lib.packer"

packer.register {
  module = "telescope",
  cmd = "Telescope",
  plugins = {
    {
      "nvim-telescope/telescope.nvim",
      setup = function() require("packages.telescope.telescope").set_keymaps() end,
      config = function()
        require("packages.telescope.telescope").init()
      end,
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-telescope/telescope-symbols.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "octarect/telescope-menu.nvim" },
        -- { "~/code/src/github.com/octarect/telescope-menu.nvim" },
      },
    },
  },
}
