local mapfuncs = {}
local mapfuncs_cnt = 0
local last_opened_path = vim.loop.cwd()

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

  return string.format('<cmd>lua require("packages.ui.telescope").mapfuncs[%d]()<CR>', i)
end

local function set_keymaps()
  local keymap = require "lib.keymap"
  local opts = { keymap.flags.silent, keymap.flags.noremap }
  keymap.nmap {
    { "<Leader>df", get_picker_cmd "builtin/git_files", opts },
    { "<Leader>dF", get_picker_cmd "builtin/find_files", opts },
    { "<Leader>dg", get_picker_cmd "builtin/live_grep", opts },
    { "<Leader>db", get_picker_cmd "builtin/buffers", opts },
    { "<Leader>dc", get_picker_cmd("builtin/colorscheme", { theme = "dropdown" }), opts },
    { "<Leader>dj", get_picker_cmd "builtin/treesitter", opts },
    -- telescope-symbols.nvim
    { "<Leader>de", get_picker_cmd("builtin/symbols", { theme = "cursor" }), opts },
    -- telescope-menu.nvim
    { "<Leader>dm", get_picker_cmd("menu/menu", { theme = "dropdown" }), opts },
    { "<Leader>d.", get_picker_cmd("menu/filetype", { theme = "dropdown" }), opts },
    { "<Leader>dd", get_picker_cmd("menu/cursor", { theme = "cursor" }), opts },
    -- telescope-file-browser.nvim
    {
      "<Leader>f",
      function() require("telescope").extensions.file_browser.file_browser { path = last_opened_path } end,
      opts,
    },
  }
end

local function init()
  local actions = require "telescope.actions"
  local config = require "core.config"

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
          ["<Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        },
      },
      winblend = 20,
      borderchars = (function()
        local b = config.window.border
        return { b[2], b[4], b[6], b[8], b[1], b[3], b[5], b[7] }
      end)(),
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
            { "🔃Packer: Sync", "PackerSync" },
            { "🔃Packer: Clean", "PackerClean" },
            { "🔃Packer: Status", "PackerStatus" },
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
            { "🔭Notification History", function() require("telescope").extensions.notify.notify() end },
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
            { " Git: Blame line", function() require("gitsigns").blame_line { full = true } end },
            { " Git: Preview hunk", function() require("gitsigns").preview_hunk() end },
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
      file_browser = (function()
        local fb_actions = require("telescope").extensions.file_browser.actions
        local stateful = function(fb_action)
          return function(bufnr, bypass)
            fb_action(bufnr, bypass)

            local action_state = require "telescope.actions.state"
            local current_picker = action_state.get_current_picker(bufnr)
            local finder = current_picker.finder
            last_opened_path = finder.path
          end
        end
        return {
          initial_mode = "normal",
          mappings = {
            n = {
              l = stateful(actions.select_default),
              c = fb_actions.copy,
              m = fb_actions.move,
              r = fb_actions.rename,
              N = fb_actions.create,
              h = stateful(fb_actions.goto_parent_dir),
              H = stateful(fb_actions.goto_cwd),
              ["."] = fb_actions.toggle_hidden,
            },
          },
        }
      end)(),
    },
  }
  require("telescope").load_extension "fzf"
  require("telescope").load_extension "menu"
  require("telescope").load_extension "file_browser"
  require("telescope").load_extension "notify"
end

return {
  set_keymaps = set_keymaps,
  init = init,
  mapfuncs = mapfuncs,
}
