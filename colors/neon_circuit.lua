vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end
vim.g.colors_name = "neon_circuit"

local palette = {
    bg             = "#1E2028",
    fg             = "#D1C5C0",
    grey           = "#6F747C",
    dark_grey      = "#3B3F4A",
    very_dark_grey = "#31343F",
    yellow         = "#FFD300",
    amber          = "#FFB800",
    cyan           = "#37EBF3",
    bright_cyan    = "#7EF9FF",
    red            = "#DB2813",
    green          = "#8BC34A",
    gold           = "#fabd2f",
    brown_grey     = "#7c6f64",
}

local highlights = {
    -- Core UI (Transparent Background)
    Normal       = { fg = palette.fg, bg = "NONE" },
    NormalNC     = { fg = palette.fg, bg = "NONE" },
    CursorLine   = { bg = palette.very_dark_grey },
    CursorColumn = { bg = palette.very_dark_grey },
    ColorColumn  = { bg = palette.very_dark_grey },
    LineNr       = { fg = palette.brown_grey, bg = "NONE" },
    CursorLineNr = { fg = palette.gold, bg = "NONE", bold = true },
    SignColumn   = { bg = "NONE" },
    FoldColumn   = { fg = palette.grey, bg = "NONE" },
    Folded       = { fg = palette.cyan, bg = palette.very_dark_grey },
    VertSplit    = { fg = palette.dark_grey },
    WinSeparator = { fg = palette.dark_grey },
    StatusLine   = { fg = palette.fg, bg = palette.very_dark_grey },
    StatusLineNC = { fg = palette.grey, bg = palette.very_dark_grey },
    Visual       = { bg = palette.dark_grey },
    VisualNOS    = { bg = palette.dark_grey },
    Search       = { fg = palette.bg, bg = palette.yellow },
    IncSearch    = { fg = palette.bg, bg = palette.cyan },
    NormalFloat  = { bg = "NONE" },
    FloatBorder  = { fg = palette.dark_grey, bg = "NONE" },
    MatchParen   = { fg = palette.cyan, bold = true },
    Question     = { fg = palette.cyan },
    ModeMsg      = { fg = palette.fg, bold = true },
    MoreMsg      = { fg = palette.cyan },
    ErrorMsg     = { fg = palette.red, bold = true },
    WarningMsg   = { fg = palette.yellow },
    Directory    = { fg = palette.cyan },
    Title        = { fg = palette.yellow, bold = true },
    NonText      = { fg = palette.dark_grey },
    SpecialKey   = { fg = palette.dark_grey },
    Conceal      = { fg = palette.grey },
    Pmenu        = { fg = palette.fg, bg = palette.very_dark_grey },
    PmenuSel     = { fg = palette.bg, bg = palette.cyan },
    PmenuSbar    = { bg = palette.dark_grey },
    PmenuThumb   = { bg = palette.grey },

    -- Indent Blankline
    IblIndent = { fg = palette.dark_grey, nocombine = true },
    IblScope  = { fg = palette.cyan, nocombine = true },

    -- Standard Syntax Highlighting (Neon Circuit Palette)
    Comment        = { fg = palette.grey, italic = true },
    Constant       = { fg = palette.amber },
    String         = { fg = palette.fg },
    Character      = { fg = palette.fg },
    Number         = { fg = palette.amber },
    Boolean        = { fg = palette.amber },
    Float          = { fg = palette.amber },
    Identifier     = { fg = palette.fg },
    Function       = { fg = palette.cyan },
    Statement      = { fg = palette.yellow, bold = true },
    Conditional    = { fg = palette.yellow, bold = true },
    Repeat         = { fg = palette.yellow, bold = true },
    Label          = { fg = palette.cyan },
    Operator       = { fg = palette.yellow },
    Keyword        = { fg = palette.yellow, bold = true },
    Exception      = { fg = palette.red },
    PreProc        = { fg = palette.bright_cyan },
    Include        = { fg = palette.cyan },
    Define         = { fg = palette.yellow },
    Macro          = { fg = palette.bright_cyan },
    PreCondit      = { fg = palette.bright_cyan },
    Type           = { fg = palette.bright_cyan },
    StorageClass   = { fg = palette.yellow },
    Structure      = { fg = palette.yellow },
    Typedef        = { fg = palette.bright_cyan },
    Special        = { fg = palette.cyan },
    SpecialChar    = { fg = palette.cyan },
    Tag            = { fg = palette.cyan },
    Delimiter      = { fg = palette.grey },
    SpecialComment = { fg = palette.grey, italic = true },
    Debug          = { fg = palette.red },
    Underlined     = { underline = true },
    Ignore         = { fg = palette.dark_grey },
    Error          = { fg = palette.red, bold = true },
    Todo           = { fg = palette.bg, bg = palette.yellow, bold = true },

    -- Treesitter Syntax Overrides
    ["@variable"] = { fg = palette.fg },
    ["@function"] = { fg = palette.cyan },
    ["@keyword"]  = { fg = palette.yellow, bold = true },
    ["@type"]     = { fg = palette.bright_cyan },
    ["@string"]   = { fg = palette.fg },
    ["@constant"] = { fg = palette.amber },
    ["@operator"] = { fg = palette.yellow },
    ["@comment"]  = { fg = palette.grey, italic = true },

    -- Diagnostics
    DiagnosticError = { fg = palette.red },
    DiagnosticWarn  = { fg = palette.yellow },
    DiagnosticInfo  = { fg = palette.cyan },
    DiagnosticHint  = { fg = palette.green },

    -- Dashboard helper groups
    NeonYellow = { fg = palette.yellow },
    NeonCyan   = { fg = palette.cyan },
    NeonGreen  = { fg = palette.green },
}

for group, hl in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, hl)
end
