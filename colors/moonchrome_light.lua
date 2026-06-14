local theme = require("core.theme")

local palette = {
    bg = "#EFF1F5",
    fg = "#272B38",
    bg_alt = "#E7EAF1",
    bg_highlight = "#B8BDCB",
    fg_alt = "#828899",
    primary = "#5055DC",
    secondary = "#6B78EE",
    error = "#D93348",
    warning = "#D46418",
    info = "#8858D4",
    hint = "#545A6A",
}

theme.apply_highlights("moonchrome_light", palette)
