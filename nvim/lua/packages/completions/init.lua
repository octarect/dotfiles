local packer = require "lib.packer"

packer.register {
  plugins = {
    {
      "neovim/nvim-lspconfig",
      event = { "BufNewFile", "BufRead" },
      config = function()
        require("packages.completions.lsp")
      end,
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
      }
    },
    {
      "hrsh7th/nvim-cmp",
      event = { "InsertEnter" },
      config = function()
        require("packages.completions.nvim-cmp")
      end,
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "tzachar/cmp-tabnine", run = "./install.sh" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-emoji" },
        { "ray-x/cmp-treesitter" },
        { "saadparwaiz1/cmp_luasnip" },
        { "onsails/lspkind-nvim" },
      }
    },
    {
      "saadparwaiz1/cmp_luasnip",
      opt = true,
      requires = {
        { "L3MON4D3/LuaSnip" },
      },
    },
    {
      "williamboman/mason.nvim",
      requires = {
        { 'williamboman/mason-lspconfig.nvim' },
      },
    },
  },
}
