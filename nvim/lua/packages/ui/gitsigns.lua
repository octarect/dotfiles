local config = require "core.config"
local keymap = require "lib.keymap"
local gitsigns = require "gitsigns"

gitsigns.setup {
  signs = {
    add = { text = "█" },
    change = { text = "█" },
    delete = { text = "█" },
    topdelete = { text = "█" },
    changedelete = { text = "█" },
    untracked = { text = "█" },
  },
  signcolumn = true,
  numhl = true,
  linehl = false,
  word_diff = false,
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = "<author>, <author_time:%F> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil,
  max_file_length = 5000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = config.window.border,
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}

keymap.nmap {
  { "[c", gitsigns.prev_hunk, { keymap.flags.silent } },
  { "]c", gitsigns.next_hunk, { keymap.flags.silent } },
}
