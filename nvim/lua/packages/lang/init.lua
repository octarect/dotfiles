local packer = require "lib.packer"

packer.register {
  plugins = {
    -- LSP
    {
      "neovim/nvim-lspconfig",
      event = { "BufNewFile", "BufRead" },
      config = function() require "packages.lang.lspconfig" end,
      requires = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "hrsh7th/cmp-nvim-lsp" },
        -- Used by lualine
        {
          "SmiteshP/nvim-navic",
          config = function() require "packages.lang.nvim-navic" end,
        },
      },
    },

    -- Syntax
    {
      "nvim-treesitter/nvim-treesitter",
      config = function() require "packages.lang.treesitter" end,
      run = ":TSUpdate",
      event = { "BufNewFile", "BufRead" },
      requires = {
        { "p00f/nvim-ts-rainbow" },
      },
    },

    -- Language/Filetype specific
    {
      "cespare/vim-toml",
      ft = { "toml" },
    },
    {
      "elzr/vim-json",
      ft = { "json" },
    },
    {
      "plasticboy/vim-markdown",
      ft = { "markdown" },
      config = function()
        vim.g.vim_markdown_folding_disabled = 1
        local keymap = require "lib.keymap"
        keymap.nmap {
          { "<LocalLeader>t", ":<C-u>TableFormat<CR>", { keymap.flags.noremap } },
          { "<LocalLeader>i", ":<C-u>HeaderIncrease<CR>", { keymap.flags.noremap } },
          { "<LocalLeader>d", ":<C-u>HeaderDecrease<CR>", { keymap.flags.noremap } },
        }
      end,
      requires = {
        { "godlygeek/tabular" },
        { "joker1007/vim-markdown-quote-syntax" },
      },
    },
    {
      "previm/previm",
      ft = { "markdown", "asciidoc" },
      config = function()
        local keymap = require "lib.keymap"
        keymap.nmap {
          { "<LocalLeader>r", ":<C-u>PrevimOpen<CR>", { keymap.flags.noremap } },
        }
      end,
      requires = {
        { "tyru/open-browser.vim" },
      },
    },
    {
      "hashivim/vim-terraform",
      ft = { "terraform" },
      config = function() vim.g.terraform_fmt_on_save = 1 end,
    },
    {
      "mattn/emmet-vim",
      ft = { "html", "eruby", "htmldjango" },
    },
  },
}
