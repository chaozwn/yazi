require("smart-enter"):setup {
  open_multi = true,
}

local tokyonight_theme = require("yatline-tokyonight"):setup "moon"

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
