local theme = require("core.theme")

local palette = {
    bg = "#EFF1F5",
    fg = "#232730",
    bg_alt = "#EFF1F5",
    bg_highlight = "#B3B8C6",
    fg_alt = "#5C6375",
    primary = "#6600FF",
    secondary = "#7A3CFF",
    error = "#FF001A",
    warning = "#FF6600",
    info = "#7A3CFF",
    hint = "#00CC66",
}

theme.apply_highlights("moonchrome_light", palette)
