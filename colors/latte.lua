local theme = require("core.theme")

local palette = {
    bg = "#eff1f5",
    fg = "#4c4f69",
    bg_alt = "#e6e9ef",
    bg_highlight = "#ccd0da",
    fg_alt = "#8c8fa1",
    primary = "#1e66f5",     -- blue
    secondary = "#ea76cb",   -- pink
    error = "#d20f39",       -- red
    warning = "#df8e1d",     -- yellow
    info = "#1e66f5",        -- blue
    hint = "#40a02b",        -- green
}

theme.apply_highlights("latte", palette)
