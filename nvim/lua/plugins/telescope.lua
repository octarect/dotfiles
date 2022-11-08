local mapfuncs = {}
local mapfuncs_cnt = 0

-- Create a dedicated function for mapping, and return a command to call it.
-- @param picker_name Picker name. ex) "builtin/find_files"
-- @param opts Picker options. The following keys are added for this function;
-- theme: Pass theme function if you want to use a theme. Default is nil (no theme)
local function get_picker_cmd(picker_name, opts)
  opts = opts or {}

  local theme = opts.theme
  opts.theme = nil

  mapfuncs_cnt = mapfuncs_cnt + 1
  local i = mapfuncs_cnt

  mapfuncs[i] = function()
    -- NOTE: require the root module before loading its children (and trigger on_lua)
    if not package.loaded["telescope"] then
      require "telescope"
    end

    local picker
    local picker_paths = vim.split(picker_name, "/")

    if picker_paths[1] == "builtin" then
      picker = require("telescope.builtin")[picker_paths[2]]
    else
      picker = require("telescope").extensions[picker_paths[1]][picker_paths[2]]
    end

    if theme == nil then
      picker(opts)
    else
      picker(require("telescope.themes")["get_" .. theme](opts))
    end
  end

  return string.format('<cmd>lua require("plugins.telescope").mapfuncs[%d]()<CR>', i)
end

local function set_keymaps()
  local set_keymap = function(...) vim.api.nvim_set_keymap(...) end
  local opts = { noremap = true, silent = true }

  set_keymap("n", "<Leader>df", get_picker_cmd "builtin/git_files", opts)
  set_keymap("n", "<Leader>dF", get_picker_cmd "builtin/find_files", opts)
  set_keymap("n", "<Leader>dg", get_picker_cmd "builtin/live_grep", opts)
  set_keymap("n", "<Leader>db", get_picker_cmd "builtin/buffers", opts)
  set_keymap("n", "<Leader>dc", get_picker_cmd("builtin/colorscheme", { theme = "dropdown" }), opts)
  set_keymap("n", "<Leader>dj", get_picker_cmd "builtin/treesitter", opts)
  -- telescope-symbols.nvim
  set_keymap("n", "<Leader>de", get_picker_cmd("builtin/symbols", { sources = { "emoji", "gitmoji" } }), opts)
  -- telescope-menu.nvim
  set_keymap("n", "<Leader>dm", get_picker_cmd("menu/menu", { theme = "dropdown" }), opts)
  set_keymap("n", "<Leader>d,", get_picker_cmd("menu/filetype", { theme = "dropdown" }), opts)
  set_keymap("n", "<Leader>dd", get_picker_cmd("menu/cursor", { theme = "cursor" }), opts)
end

local function init()
  local actions = require "telescope.actions"
  require("telescope").setup {
    defaults = {
      mappings = {
        i = {
          ["<C-u>"] = false,
          -- Open file in horizontal by <C-s> instead of <C-x>
          ["<C-x>"] = false,
          ["<C-s>"] = actions.file_split,
          -- Open file in new tab. (Disable tmux prefix <C-t>)
          ["<C-t>"] = false,
        },
        n = {
          ["<esc>"] = actions.close,
          ["<space>"] = actions.toggle_selection,
        },
      },
      winblend = 20,
      borderchars = { "-", "|", "-", "|", "+", "+", "+", "+" },
      color_devicons = true,
    },
    pickers = {
      buffers = {
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["<C-d>"] = actions.delete_buffer,
          },
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      menu = {
        default = {
          items = {
            { "⚙️ LSPInfo", "LspInfo" },
            { "⚙️ Manage LSP servers", "Mason" },
            { "🔃Dein: Recache runtimepath", "call dein#recache_runtimepath()" },
            {
              "🔌Dein: Edit plugin settings",
              [[ lua require"telescope.builtin".find_files{ cwd = vim.fn.fnamemodify(vim.env.MYVIMRC, ":h") .. "/dein" } ]],
            },
            { "🌈Change colorscheme", "Telescope colorscheme theme=dropdown" },
            { "📁Browse files", "Telescope find_files" },
            { "📁Browse files in Git Repository", "Telescope git_files" },
            { "🔍Search in current directory (live_grep)", "Telescope live_grep" },
            { " Lists open buffers", "Telescope buffers" },
            { " Lists available commands", "Telescope commands" },
            { " Lists tags in current directory", "Telescope tags" },
            { " Lists marks", "Telescope marks" },
            { " Lists jumplist", "Telescope jumplist" },
            { " Lists command history", "Telescope command_history theme=ivy" },
            { " Lists search history", "Telescope search_history theme=ivy" },
            { " Lists registers (Paste yanked string)", "Telescope registers" },
            { " Lists vim autocommands", "Telescope autocommands" },
            { "🎮Lists keymaps (keymappings)", "Telescope keymaps" },
            { "⚙️ Show vim options", "Telescope vim_options" },
            { "😀Insert emoji", [[ lua require"telescope.builtin".symbols{ sources = {"emoji", "gitmoji"} } ]] },
            { "😀Insert emoji (Nerd Fonts)", [[ lua require"telescope.builtin".symbols{ sources = {"nerd"} } ]] },
            { "😀Insert emoji (kaomoji)", [[ lua require"telescope.builtin".symbols{ sources = {"kaomoji"} } ]] },
            { "🔭Open filetype menu", "Telescope filetype" },
          },
        },
        cursor = {
          items = {
            { "🔍Search for the current word", "Telescope grep_string" },
            { "📚Spell suggestions", "Telescope spell_suggest" },
            { " Paste", "Telescope registers" },
            { "😀Insert emoji", [[ lua require"telescope.builtin".symbols{ sources = {"emoji", "gitmoji"} } ]] },
            { "😀Insert emoji (Nerd Fonts)", [[ lua require"telescope.builtin".symbols{ sources = {"nerd"} } ]] },
            { "😀Insert emoji (kaomoji)", [[ lua require"telescope.builtin".symbols{ sources = {"kaomoji"} } ]] },
          },
        },
        filetype = {
          lua = {
            items = {
              { display = "Format", value = "!stylua %" },
            },
          },
          markdown = {
            items = {
              { "✨Format table", "TableFormat" },
              { "🔍Preview", "PrevimOpen" },
              { "🚩Increase headers", "HeaderIncrease" },
              { "🚩Decrease headers", "HeaderDecrease" },
              { "🚩Convert Setex headers to Atx", "SetexToAtx" },
              { "📖Table of contents", "Toch" },
            },
          },
        },
      },
    },
  }
  require("telescope").load_extension "fzf"
  require("telescope").load_extension "menu"
end

return {
  set_keymaps = set_keymaps,
  init = init,
  mapfuncs = mapfuncs,
}
