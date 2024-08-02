local moon_palette = {
  bg = "#222436",
  bg_dark = "#1e2030",
  bg_highlight = "#2f334d",
  blue = "#82aaff",
  blue0 = "#3e68d7",
  blue1 = "#65bcff",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#b4f9f8",
  blue7 = "#394b70",
  comment = "#636da6",
  cyan = "#86e1fc",
  dark3 = "#545c7e",
  dark5 = "#737aa2",
  fg = "#c8d3f5",
  fg_dark = "#828bb8",
  fg_gutter = "#3b4261",
  green = "#c3e88d",
  green1 = "#4fd6be",
  green2 = "#41a6b5",
  magenta = "#c099ff",
  magenta2 = "#ff007c",
  orange = "#ff966c",
  purple = "#fca7ea",
  red = "#ff757f",
  red1 = "#c53b53",
  teal = "#4fd6be",
  terminal_black = "#444a73",
  yellow = "#ffc777",
  git = {
    add = "#b8db87",
    change = "#7ca1f2",
    delete = "#e26a75",
  },
}

local storm_palette = {
  bg = "#24283b",
  bg_dark = "#1f2335",
  bg_highlight = "#292e42",
  blue = "#7aa2f7",
  blue0 = "#3d59a1",
  blue1 = "#2ac3de",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#b4f9f8",
  blue7 = "#394b70",
  comment = "#565f89",
  cyan = "#7dcfff",
  dark3 = "#545c7e",
  dark5 = "#737aa2",
  fg = "#c0caf5",
  fg_dark = "#a9b1d6",
  fg_gutter = "#3b4261",
  green = "#9ece6a",
  green1 = "#73daca",
  green2 = "#41a6b5",
  magenta = "#bb9af7",
  magenta2 = "#ff007c",
  orange = "#ff9e64",
  purple = "#9d7cd8",
  red = "#f7768e",
  red1 = "#db4b4b",
  teal = "#1abc9c",
  terminal_black = "#414868",
  yellow = "#e0af68",
  git = {
    add = "#449dab",
    change = "#6183bb",
    delete = "#914c54",
  },
}

local night_palette = {
  bg = "#1a1b26",
  bg_dark = "#16161e",
  bg_highlight = "#292e42",
  blue = "#7aa2f7",
  blue0 = "#3d59a1",
  blue1 = "#2ac3de",
  blue2 = "#0db9d7",
  blue5 = "#89ddff",
  blue6 = "#b4f9f8",
  blue7 = "#394b70",
  comment = "#565f89",
  cyan = "#7dcfff",
  dark3 = "#545c7e",
  dark5 = "#737aa2",
  fg = "#c0caf5",
  fg_dark = "#a9b1d6",
  fg_gutter = "#3b4261",
  green = "#9ece6a",
  green1 = "#73daca",
  green2 = "#41a6b5",
  magenta = "#bb9af7",
  magenta2 = "#ff007c",
  orange = "#ff9e64",
  purple = "#9d7cd8",
  red = "#f7768e",
  red1 = "#db4b4b",
  teal = "#1abc9c",
  terminal_black = "#414868",
  yellow = "#e0af68",
  git = {
    add = "#449dab",
    change = "#6183bb",
    delete = "#914c54",
  },
}

--- Gets the Tokyonight theme.
--- @param flavor string Flavor of the theme: "moon", "night" or "storm".
--- @return table theme Used in Yatline.
local function tokyonight_theme(flavor)
  local tokyonight_palette
  if flavor == "moon" then
    tokyonight_palette = moon_palette
  elseif flavor == "night" then
    tokyonight_palette = night_palette
  elseif flavor == "storm" then
    tokyonight_palette = storm_palette
  end

  return {
    -- yatline
    section_separator_open = "",
    section_separator_close = "",

    inverse_separator_open = "",
    inverse_separator_close = "",

    part_separator_open = "",
    part_separator_close = "",

    style_a = {
      fg = tokyonight_palette.bg_dark,
      bg_mode = {
        normal = tokyonight_palette.blue,
        select = tokyonight_palette.magenta,
        un_set = tokyonight_palette.red,
      },
    },
    style_b = { bg = tokyonight_palette.fg_gutter, fg = tokyonight_palette.blue },
    style_c = { bg = tokyonight_palette.bg_dark, fg = tokyonight_palette.fg_dark },

    permissions_t_fg = tokyonight_palette.green,
    permissions_r_fg = tokyonight_palette.yellow,
    permissions_w_fg = tokyonight_palette.red,
    permissions_x_fg = tokyonight_palette.orange,
    permissions_s_fg = tokyonight_palette.purple,

    selected = { icon = "󰻭", fg = tokyonight_palette.yellow },
    copied = { icon = "", fg = tokyonight_palette.green },
    cut = { icon = "", fg = tokyonight_palette.red },

    total = { icon = "", fg = tokyonight_palette.yellow },
    succ = { icon = "", fg = tokyonight_palette.green },
    fail = { icon = "", fg = tokyonight_palette.red },
    found = { icon = "", fg = tokyonight_palette.blue },
    processed = { icon = "", fg = tokyonight_palette.green },

    -- yatline-githead
    prefix_color = tokyonight_palette.red,
    branch_color = tokyonight_palette.purple,
    commit_color = tokyonight_palette.green2,
    stashes_color = tokyonight_palette.magenta2,
    state_color = tokyonight_palette.maroon,
    staged_color = tokyonight_palette.green1,
    unstaged_color = tokyonight_palette.red1,
    untracked_color = tokyonight_palette.magenta,
  }
end

return {
  setup = function(_, args)
    args = args or "moon"

    return tokyonight_theme(args)
  end,
}
