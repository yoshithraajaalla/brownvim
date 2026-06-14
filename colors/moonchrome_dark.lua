local theme = require("core.theme")

local palette = {
    bg = "#0F1116",
    fg = "#ECEEF5",
    bg_alt = "#14171F",
    bg_highlight = "#262C40",
    fg_alt = "#454B62",
    primary = "#7A88F0",
    secondary = "#9099F5",
    error = "#E84460",
    warning = "#E87828",
    info = "#AA78EE",
    hint = "#B8BDCE",
}

theme.apply_highlights("moonchrome_dark", palette)
