require'toggleterm'.setup{
  hide_numbers = false,
  start_in_insert = false,
  close_on_exit = true,
  float_opts = {
    border = { '+', '-', '+', '|', '+', '-', '+', '|' },
    width = function()
      return vim.o.columns > 100 and vim.fn.float2nr(vim.o.columns * 0.6) or 90
    end,
    height = function()
      return vim.o.lines > 40 and vim.fn.float2nr(vim.o.lines * 5 / 8 ) or 24
    end,
    highlights = {
      border = 'Normal',
      background = 'Normal',
    }
  },
}

local Terminal = require'toggleterm.terminal'.Terminal

local terminals = {
  shell = {
    map = '<Leader>tf',
    terminal = Terminal:new{
      cmd = vim.o.shell,
      direction = 'float',
    },
  },
  btm = {
    terminal = Terminal:new{
      cmd = 'btm',
      direction = 'float',
    },
  },
}

function _G.toggleterm_toggle(name)
  terminals[name].terminal:toggle()
end

for k, v in pairs(terminals) do
  if type(v.map) == 'string' and #v.map > 0 then
    local rhs = '<cmd>lua toggleterm_toggle("' .. k ..'")<CR>'
    vim.api.nvim_set_keymap('n', v.map, rhs, { noremap = true, silent = true })
  end
end

function _G.toggleterm_init_buf()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<CR>', opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j><C-j>', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua toggleterm_init_buf()')
