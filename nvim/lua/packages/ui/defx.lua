local on_filetype = require("lib.helper").on_filetype

on_filetype("defx", function()
  local keymap = require "lib.keymap"
  local opts = { keymap.flags.silent, keymap.flags.noremap, keymap.flags.expr }
  keymap.bnmap {
    { "<CR>", "defx#do_action('open')", opts },
    { "l", "defx#do_action('open')", opts },
    { "c", "defx#do_action('copy')", opts },
    { "m", "defx#do_action('move')", opts },
    { "p", "defx#do_action('paste')", opts },
    { "v", "defx#do_action('open', 'vsplit')", opts },
    { "N", "defx#do_action('new_file')", opts },
    { "M", "defx#do_action('new_multiple_files')", opts },
    { "C", "defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')", opts },
    { "d", "defx#do_action('remove')", opts },
    { "r", "defx#do_action('rename')", opts },
    { "yy", "defx#do_action('yank_path')", opts },
    { ".", "defx#do_action('toggle_ignored_files')", opts },
    { "q", "defx#do_action('quit')", opts },
    { "<Space>", "defx#do_action('toggle_select') . 'j'", opts },
    { "*", "defx#do_action('toggle_select_all')", opts },
    { "j", "line('.') == line('$') ? 'gg' : 'j'", opts },
    { "k", "line('.') == 1 ? 'G' : 'k'", opts },
    { "R", "defx#do_action('redraw')", opts },
    { "<C-g>", "defx#do_action('print')", opts },
  }
end)
