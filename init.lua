require("smart-enter"):setup {
  open_multi = true,
}
require("eza-preview"):setup()

local tokyonight_theme = require("yatline-tokyonight"):setup "moon"

require("searchjump"):setup {
  opt_unmatch_fg = "#545c7e",
  opt_match_str_fg = "#c8d3f5",
  opt_match_str_bg = "#3e68d7",
  opt_lable_fg = "#c8d3f5",
  opt_lable_bg = "#ff007c",
  opt_only_current = false, -- only search the current window
  -- opt_search_patterns = {}  -- demo:{"%.e%d+","s%d+e%d+"}
}

require("yatline"):setup {
  theme = tokyonight_theme,
  tab_width = 20,
  tab_use_inverse = false,
  show_background = true,
  display_header_line = true,
  display_status_line = true,

  header_line = {
    left = {
      section_a = { { type = "line", custom = false, name = "tabs", params = { "left" } } },
      section_b = {},
      section_c = {},
    },
    right = {
      section_a = {
        { type = "string", custom = false, name = "date", params = { "%X" } },
      },
      section_b = {
        { type = "string", custom = false, name = "date", params = { "%Y-%m-%d" } },
      },
      section_c = {
        -- { type = "coloreds", custom = false, name = "githead" },
      },
    },
  },

  status_line = {
    left = {
      section_a = {
        { type = "string", custom = false, name = "tab_mode" },
      },
      section_b = {
        { type = "string", custom = false, name = "hovered_size" },
      },
      section_c = {
        { type = "string", custom = false, name = "hovered_name" },
        { type = "coloreds", custom = false, name = "count" },
      },
    },
    right = {
      section_a = {
        { type = "string", custom = false, name = "cursor_position" },
      },
      section_b = {
        { type = "string", custom = false, name = "cursor_percentage" },
      },
      section_c = {
        { type = "string", custom = false, name = "hovered_file_extension", params = { true } },
      },
    },
  },
}
