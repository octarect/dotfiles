local packer = require "lib.packer"

packer.register {
  plugins = {
    {
      "neovim/nvim-lspconfig",
      event = { "BufNewFile", "BufRead" },
      config = function()
        _G.load_dependencies("nvim-lspconfig")
        require("packages.completions.lsp")
      end,
      requires = {
        { "hrsh7th/cmp-nvim-lsp", opt = true },
      }
    },
    {
      "hrsh7th/nvim-cmp",
      event = { "InsertEnter" },
      config = function()
        _G.load_dependencies("nvim-cmp")
        require("packages.completions.nvim-cmp")
      end,
      requires = {
        { "hrsh7th/cmp-nvim-lsp", opt = true },
        { "tzachar/cmp-tabnine", opt = true, run = "./install.sh" },
        { "hrsh7th/cmp-buffer", opt = true },
        { "hrsh7th/cmp-path", opt = true },
        { "hrsh7th/cmp-cmdline", opt = true },
        { "hrsh7th/cmp-emoji", opt = true },
        { "ray-x/cmp-treesitter", opt = true },
        { "saadparwaiz1/cmp_luasnip", opt = true },
        { "onsails/lspkind-nvim", opt = true },
      }
    },
    {
      "saadparwaiz1/cmp_luasnip",
      config = function()
        _G.load_dependencies("cmp_luasnip")
      end,
      opt = true,
      requires = {
        { "L3MON4D3/LuaSnip", opt = true },
      },
    },
    {
      "williamboman/mason.nvim",
      config = function()
        _G.load_dependencies("mason.nvim")
      end,
      requires = {
        { 'williamboman/mason-lspconfig.nvim', opts = true },
      },
    },
  },
}
