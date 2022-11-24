local packer = require "lib.packer"

packer.register {
  plugins = {
    -- Statusline
    {
      "itchyny/lightline.vim",
      setup = function() require "packages.ui.lightline" end,
      requires = {
        { "airblade/vim-gitgutter" },
        { "ryanoasis/vim-devicons" },
        { "itchyny/vim-gitbranch" },
      },
    },

    -- Visualize git diffs
    {
      "airblade/vim-gitgutter",
      setup = function()
        -- Use block as sign
        vim.g.gitgutter_sign_added = "█"
        vim.g.gitgutter_sign_modified = "█"
        vim.g.gitgutter_sign_removed = "█"
        vim.g.gitgutter_sign_removed_first_line = "█"
        vim.g.gitgutter_sign_removed_above_and_below = "█"
        vim.g.gitgutter_sign_modified_removed = "█"
        -- Keymappings for hunk jumping
        local keymap = require "lib.keymap"
        local silent = keymap.flags.silent
        keymap.nmap {
          { "[c", "<Plug>(GitGutterPrevHunk)", { silent } },
          { "]c", "<Plug>(GitGutterNextHunk)", { silent } },
          { "<Leader>ggd", "<Cmd>GitGutterPreviewHunk>CR>", { silent } },
        }
      end,
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
        -- { "~/code/src/github.com/octarect/telescope-menu.nvim" },
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
