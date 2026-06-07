local theme = require("core.theme")

local palette = {
    bg = "#1E2028",
    fg = "#D1C5C0",
    bg_alt = "#31343F",
    bg_highlight = "#3B3F4A",
    fg_alt = "#6F747C",
    primary = "#FFD300",     -- yellow
    secondary = "#37EBF3",   -- cyan
    error = "#DB2813",       -- red
    warning = "#FFB800",     -- amber
    info = "#37EBF3",        -- cyan
    hint = "#8BC34A",        -- green
}

theme.apply_highlights("neon_circuit", palette)
