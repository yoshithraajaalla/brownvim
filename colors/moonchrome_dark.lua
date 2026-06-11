local theme = require("core.theme")

local palette = {
    bg = "#0F1116",
    fg = "#B8BDCE",
    bg_alt = "#14171F",
    bg_highlight = "#1F2436",
    fg_alt = "#606780",
    primary = "#8855FF",
    secondary = "#9966FF",
    error = "#FF001A",
    warning = "#FF6600",
    info = "#9966FF",
    hint = "#00CC66",
}

theme.apply_highlights("moonchrome_dark", palette)
