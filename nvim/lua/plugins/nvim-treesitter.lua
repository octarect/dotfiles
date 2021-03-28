require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  -- Install parsers automatically
  ensure_installed = 'all',
  -- p00f/nvim-ts-rainbow
  rainbow = {
    enable = true,
  },
}
