local packer = require "lib.packer"

packer.register {
  plugins = {
    -- Completion
    {
      "hrsh7th/nvim-cmp",
      event = { "InsertEnter" },
      config = function() require "packages.edit.nvim-cmp" end,
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "tzachar/cmp-tabnine", run = "./install.sh" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-emoji" },
        { "ray-x/cmp-treesitter" },
        {
          "saadparwaiz1/cmp_luasnip",
          requires = {
            { "L3MON4D3/LuaSnip" },
          },
        },
        { "onsails/lspkind-nvim" },
      },
    },

    -- Edit
    {
      "scrooloose/nerdcommenter",
      keys = "<Plug>NERDCom",
      setup = function()
        vim.g.NERDSpaceDelims = 1
        vim.g.NERDDefaultAlign = "left"
        vim.g.NERDCompactSexyComs = 1
        local keymap = require "lib.keymap"
        keymap.nmap {
          { "co", "<Plug>NERDCommenterToggle", { keymap.flags.silent } },
        }
        keymap.vmap {
          { "co", "<Plug>NERDCommenterToggle", { keymap.flags.silent } },
        }
      end,
    },
    {
      "junegunn/vim-easy-align",
      cmd = "EasyAlign",
      setup = function()
        local keymap = require "lib.keymap"
        keymap.vmap {
          { "<CR>", ":EasyAlign<CR>", { keymap.flags.silent, keymap.flags.noremap } },
        }
      end,
    },
    {
      "windwp/nvim-autopairs",
      event = { "InsertEnter" },
      config = function() require("nvim-autopairs").setup {} end,
    },

    -- Editorconfig support
    {
      "editorconfig/editorconfig-vim",
      event = { "BufNewFile", "BufRead" },
    },
  },
}
