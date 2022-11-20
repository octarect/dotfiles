local packer = require "lib.packer"

_G.keymap = require("lib.keymap")

packer.register {
  plugins = {
    -- Statusline
    {
      "itchyny/lightline.vim",
      setup = function()
        require("packages.lightline")
      end,
      requires = {
        {
          "airblade/vim-gitgutter",
          setup = function()
            -- Use block as sign
            vim.g.gitgutter_sign_added                   = '█'
            vim.g.gitgutter_sign_modified                = '█'
            vim.g.gitgutter_sign_removed                 = '█'
            vim.g.gitgutter_sign_removed_first_line      = '█'
            vim.g.gitgutter_sign_removed_above_and_below = '█'
            vim.g.gitgutter_sign_modified_removed        = '█'
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
        { "ryanoasis/vim-devicons" },
        { "itchyny/vim-gitbranch" },
      },
    },
    { "f-person/git-blame.nvim" },
    {
      "itchyny/vim-parenmatch",
      setup = function()
        vim.g.loaded_matchparen = 1
        vim.g.parentmatch_highlight = 0
        vim.api.nvim_set_hl(0, "ParenMatch", { link = "MatchParen" })
      end,
    },

    -- File explorer
    {
      "Shougo/defx.nvim",
      cmd = "Defx",
      setup = function()
        _G.keymap.nmap {
          { "<Leader>f", "<Cmd>Defx -listed -resume -buffer-name=tab`tabpagenr()` -columns=icons:filename:size:time<CR>", { _G.keymap.flags.silent } },
        }
      end,
      config = function()
        require("packages.defx")
      end,
      run = ":UpdateRemotePlugins",
      requires = {
        { "kristijanhusak/defx-icons" },
      },
    },

    -- Terminal
    {
      "akinsho/toggleterm.nvim",
      keys = { {"n", "<Leader>t" } },
      config = function()
        require("packages.toggleterm")
      end,
    },

    -- Edit
    {
      "scrooloose/nerdcommenter",
      keys = "<Plug>NERDCom",
      setup = function()
        vim.g.NERDSpaceDelims = 1
        vim.g.NERDDefaultAlign = "left"
        vim.g.NERDCompactSexyComs = 1
        _G.keymap.nmap {
          { "co", "<Plug>NERDCommenterToggle", { _G.keymap.flags.silent } },
        }
        _G.keymap.vmap {
          { "co", "<Plug>NERDCommenterToggle", { _G.keymap.flags.silent } },
        }
      end,
    },
    {
      "junegunn/vim-easy-align",
      cmd = "EasyAlign",
      setup = function()
        _G.keymap.vmap {
          { "<CR>", ":EasyAlign<CR>", { _G.keymap.flags.silent, _G.keymap.flags.noremap } },
        }
      end,
    },
    {
      "rhysd/accelerated-jk",
      keys = {
        { "n", "<Plug>(accelerated_jk_gj)" },
        { "n", "<Plug>(accelerated_jk_gk)" },
      },
      setup = function()
        _G.keymap.nmap {
          { "j", "<Plug>(accelerated_jk_gj)", { _G.keymap.flags.silent } },
          { "k", "<Plug>(accelerated_jk_gk)", { _G.keymap.flags.silent } },
        }
      end,
    },
    {
      "windwp/nvim-autopairs",
      event = { "InsertEnter" },
      config = function()
        require("nvim-autopairs").setup {}
      end,
    },
    {
      "itchyny/vim-cursorword",
      event = { "BufNewFile", "BufRead" },
    },
    {
      "editorconfig/editorconfig-vim",
      event = { "BufNewFile", "BufRead" },
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
        _G.keymap.nmap {
          { "<LocalLeader>t", ":<C-u>TableFormat<CR>", { _G.keymap.flags.noremap } },
          { "<LocalLeader>i", ":<C-u>HeaderIncrease<CR>", { _G.keymap.flags.noremap } },
          { "<LocalLeader>d", ":<C-u>HeaderDecrease<CR>", { _G.keymap.flags.noremap } },
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
        _G.keymap.nmap {
          { "<LocalLeader>r", ":<C-u>PrevimOpen<CR>", },
        }
      end,
      requires = {
        { "tyru/open-browser.vim" },
      },
    },
    {
      "hashivim/vim-terraform",
      ft = { "terraform" },
      config = function()
        vim.g.terraform_fmt_on_save = 1
      end,
    },
    {
      "mattn/emmet-vim",
      ft = { "html", "eruby", "htmldjango" },
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
