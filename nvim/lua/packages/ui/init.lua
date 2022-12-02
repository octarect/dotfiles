local packer = require "lib.packer"

packer.register {
  -- Statusline
  plugins = {
    {
      "nvim-lualine/lualine.nvim",
      config = function() require "packages.ui.lualine" end,
      requires = {
        { "nvim-tree/nvim-web-devicons" },
      },
    },

    -- Visualize git diffs and blame
    {
      "lewis6991/gitsigns.nvim",
      config = function() require "packages.ui.gitsigns" end,
    },

    -- Fuzzy finder
    {
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      cmd = "Telescope",
      setup = function() require("packages.ui.telescope").set_keymaps() end,
      config = function() require("packages.ui.telescope").init() end,
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-telescope/telescope-symbols.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "octarect/telescope-menu.nvim" },
      },
    },

    -- File explorer
    {
      "Shougo/defx.nvim",
      cmd = "Defx",
      setup = function()
        local keymap = require "lib.keymap"
        keymap.nmap {
          {
            "<Leader>f",
            "<Cmd>Defx -listed -resume -buffer-name=tab`tabpagenr()` -columns=icons:filename:size:time<CR>",
            { keymap.flags.silent },
          },
        }
      end,
      config = function() require "packages.ui.defx" end,
      run = ":UpdateRemotePlugins",
      requires = {
        { "kristijanhusak/defx-icons" },
      },
    },

    -- Terminal
    {
      "akinsho/toggleterm.nvim",
      keys = { { "n", "<Leader>t" } },
      config = function() require "packages.ui.toggleterm" end,
    },

    -- Colorschemes
    { "tomasr/molokai" },
    { "haishanh/night-owl.vim" },
    {
      "rhysd/vim-color-spring-night",
      config = function()
        vim.g.spring_night_high_contrast = 1
        vim.g.spring_night_highlight_terminal = 1
        vim.g.spring_night_cterm_italic = 1
      end,
    },
    {
      "hardcoreplayers/oceanic-material",
      config = function()
        vim.g.oceanic_material_allow_bold = 1
        vim.g.oceanic_material_allow_italic = 1
      end,
    },
  },
}
