local get_sections = function(active)
  local sections = {
    lualine_a = { "mode" },
    lualine_b = { "filename" },
    lualine_c = {},
    lualine_x = { "diagnostics", "diff", "branch", "fileformat", "encoding", "filetype" },
    lualine_y = { "searchcount", "progress" },
    lualine_z = { "location" },
  }
  if not active then
    sections.lualine_a = {}
  end
  return sections
end

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = get_sections(true),
  inactive_sections = get_sections(false),
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}
