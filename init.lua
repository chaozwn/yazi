require("searchjump"):setup {
  opt_unmatch_fg = "#928374",
  opt_match_str_fg = "#000000",
  opt_match_str_bg = "#73AC3A",
  opt_lable_fg = "#EADFC8",
  opt_lable_bg = "#BA603D",
}

require("eza-preview"):setup()

local tokyonight_theme = require("yatline-tokyonight"):setup "moon"
-- local tokyonight_theme = require("yatline-catppuccin"):setup "moon"

require("yatline"):setup {
  theme = tokyonight_theme,
  tab_width = 20,
  tab_use_inverse = false,
  show_background = true,
  display_header_line = true,
  display_status_line = true,

  header_line = {
    left = {
      section_a = {
        { type = "line", custom = false, name = "tabs", params = { "left" } },
      },
      section_b = {},
      section_c = {},
    },
    right = {
      section_a = {
        { type = "string", custom = false, name = "date", params = { "%A, %d %B %Y" } },
      },
      section_b = {
        { type = "string", custom = false, name = "date", params = { "%X" } },
      },
      section_c = {},
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
        { type = "coloreds", custom = false, name = "permissions" },
      },
    },
  },
}

require("searchjump"):setup {
  opt_unmatch_fg = "#928374",
  opt_match_str_fg = "#000000",
  opt_match_str_bg = "#73AC3A",
  opt_lable_fg = "#EADFC8",
  opt_lable_bg = "#BA603D",
}

require("eza-preview"):setup()
