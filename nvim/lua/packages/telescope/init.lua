local packer = require "lib.packer"

packer.register {
  module = "telescope",
  cmd = "Telescope",
  plugins = {
    {
      "nvim-telescope/telescope.nvim",
      setup = function() require("packages.telescope.telescope").set_keymaps() end,
      config = function()
        _G.load_dependencies("telescope.nvim")
        require("packages.telescope.telescope").init()
      end,
      requires = {
        { "nvim-lua/plenary.nvim", opt = true },
        { "nvim-tree/nvim-web-devicons", opt = true },
        { "nvim-telescope/telescope-symbols.nvim", opt = true },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
        { "octarect/telescope-menu.nvim", opt = true },
        -- { "~/code/src/github.com/octarect/telescope-menu.nvim", opt = true },
      },
    },
  },
}
