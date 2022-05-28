local ts_config = {
  highlight = {
    enable = true,
    disable = {},
  },
  -- Install parsers automatically
  ensure_installed = 'all',
  ignore_install = {},
  -- p00f/nvim-ts-rainbow
  rainbow = {
    enable = true,
  },
}

if jit.os == 'OSX' then
  -- Ignore haskell until C++11 related bug in macOS is fixed.
  table.insert(ts_config.ignore_install, 'haskell')
  -- An error about Xcode occured on my environment
  table.insert(ts_config.ignore_install, 'phpdoc')
end

require'nvim-treesitter.configs'.setup(ts_config)
