vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end
vim.g.colors_name = "latte"

local palette = {
    rosewater = "#dc8a78",
    flamingo  = "#dd7878",
    pink      = "#ea76cb",
    mauve     = "#8839ef",
    red       = "#d20f39",
    maroon    = "#e64553",
    peach     = "#fe640b",
    yellow    = "#df8e1d",
    green     = "#40a02b",
    teal      = "#179299",
    sky       = "#04a5e5",
    sapphire  = "#209fb5",
    blue      = "#1e66f5",
    lavender  = "#7287fd",
    text      = "#4c4f69",
    subtext1  = "#5c5f77",
    subtext0  = "#6c6f85",
    overlay2  = "#7c7f93",
    overlay1  = "#8c8fa1",
    overlay0  = "#9ca0b0",
    surface2  = "#acb0be",
    surface1  = "#bcc0cc",
    surface0  = "#ccd0da",
    base      = "#eff1f5",
    mantle    = "#e6e9ef",
    crust     = "#dce0e8",
}

local highlights = {
    -- Normal / Editor UI
    Normal          = { fg = palette.text, bg = "NONE" },
    NormalNC        = { fg = palette.text, bg = "NONE" },
    CursorLine      = { bg = palette.surface0 },
    CursorColumn    = { bg = palette.surface0 },
    ColorColumn     = { bg = palette.surface0 },
    LineNr          = { fg = palette.overlay1, bg = "NONE" },
    CursorLineNr    = { fg = palette.lavender, bg = "NONE", bold = true },
    SignColumn      = { bg = "NONE" },
    FoldColumn      = { fg = palette.overlay0, bg = "NONE" },
    Folded          = { fg = palette.blue, bg = palette.surface0 },
    VertSplit       = { fg = palette.surface1 },
    WinSeparator    = { fg = palette.surface1 },
    StatusLine      = { fg = palette.text, bg = palette.mantle },
    StatusLineNC    = { fg = palette.subtext0, bg = palette.mantle },
    Visual          = { bg = palette.surface2 },
    VisualNOS       = { bg = palette.surface2 },
    Search          = { fg = palette.base, bg = palette.blue },
    IncSearch       = { fg = palette.base, bg = palette.pink },
    NormalFloat     = { bg = "NONE" },
    FloatBorder     = { fg = palette.surface1, bg = "NONE" },
    MatchParen      = { fg = palette.peach, bold = true },
    Question        = { fg = palette.blue },
    ModeMsg         = { fg = palette.text, bold = true },
    MoreMsg         = { fg = palette.blue },
    ErrorMsg        = { fg = palette.red, bold = true },
    WarningMsg      = { fg = palette.yellow },
    Directory       = { fg = palette.blue },
    Title           = { fg = palette.blue, bold = true },
    NonText         = { fg = palette.overlay0 },
    SpecialKey      = { fg = palette.overlay0 },
    Conceal         = { fg = palette.overlay1 },
    Pmenu           = { fg = palette.text, bg = palette.mantle },
    PmenuSel        = { fg = palette.base, bg = palette.blue },
    PmenuSbar       = { bg = palette.surface1 },
    PmenuThumb      = { bg = palette.surface2 },

    -- Standard Syntax Highlighting
    Comment         = { fg = palette.overlay1, italic = true },
    Constant        = { fg = palette.peach },
    String          = { fg = palette.green },
    Character       = { fg = palette.green },
    Number          = { fg = palette.peach },
    Boolean         = { fg = palette.peach },
    Float           = { fg = palette.peach },
    Identifier      = { fg = palette.flamingo },
    Function        = { fg = palette.blue },
    Statement       = { fg = palette.mauve },
    Conditional     = { fg = palette.red },
    Repeat          = { fg = palette.red },
    Label           = { fg = palette.blue },
    Operator        = { fg = palette.sky },
    Keyword         = { fg = palette.mauve },
    Exception       = { fg = palette.red },
    PreProc         = { fg = palette.pink },
    Include         = { fg = palette.blue },
    Define          = { fg = palette.mauve },
    Macro           = { fg = palette.pink },
    PreCondit       = { fg = palette.pink },
    Type            = { fg = palette.yellow },
    StorageClass    = { fg = palette.yellow },
    Structure       = { fg = palette.yellow },
    Typedef         = { fg = palette.yellow },
    Special         = { fg = palette.pink },
    SpecialChar     = { fg = palette.pink },
    Tag             = { fg = palette.blue },
    Delimiter       = { fg = palette.overlay2 },
    SpecialComment  = { fg = palette.overlay1, italic = true },
    Debug           = { fg = palette.red },
    Underlined      = { underline = true },
    Ignore          = { fg = palette.overlay0 },
    Error           = { fg = palette.red, bold = true },
    Todo            = { fg = palette.base, bg = palette.yellow, bold = true },

    -- Treesitter Syntax Overrides (Standard mappings)
    ["@variable"]   = { fg = palette.text },
    ["@function"]   = { fg = palette.blue },
    ["@keyword"]    = { fg = palette.mauve },
    ["@string"]     = { fg = palette.green },
    ["@comment"]    = { fg = palette.overlay1, italic = true },
    ["@constant"]   = { fg = palette.peach },
    ["@type"]       = { fg = palette.yellow },
    ["@operator"]   = { fg = palette.sky },

    -- Diagnostics
    DiagnosticError = { fg = palette.red },
    DiagnosticWarn  = { fg = palette.yellow },
    DiagnosticInfo  = { fg = palette.blue },
    DiagnosticHint  = { fg = palette.teal },

    -- Dashboard helper groups
    NeonYellow      = { fg = palette.blue }, -- ASCII art
    NeonCyan        = { fg = palette.blue }, -- Tagline
    NeonGreen       = { fg = palette.text }, -- Buttons
}

for group, hl in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, hl)
end
