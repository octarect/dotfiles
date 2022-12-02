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
    theme = "material",
    component_separators = { left = "", right = "|" },
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
  tabline = {
    lualine_a = {
      { "filetype", colored = false, icon_only = true },
      "filename",
    },
    lualine_b = {
      -- The following component will be enabled after loading nvim-navic
      {
        function() return require("nvim-navic").get_location() end,
        cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      { "tabs", mode = 2 },
    },
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}
