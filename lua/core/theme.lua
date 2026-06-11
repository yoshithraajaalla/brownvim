local M = {}

M._current_palette = nil
M._timer = nil
M._os_registry_theme = nil

---@class SemanticPalette
---@field bg string
---@field fg string
---@field bg_alt string
---@field bg_highlight string
---@field fg_alt string
---@field primary string
---@field secondary string
---@field error string
---@field warning string
---@field info string
---@field hint string

--- Register the active palette. Called by colorscheme files.
function M.register_palette(palette)
    M._current_palette = palette
end

function M.palette()
    return M._current_palette or M.fallback_palette()
end

function M.fallback_palette()
    return {
        bg = "#0F1116", fg = "#B8BDCE", bg_alt = "#14171F", bg_highlight = "#1F2436",
        fg_alt = "#606780", primary = "#8855FF", secondary = "#9966FF",
        error = "#FF001A", warning = "#FF6600", info = "#9966FF", hint = "#00CC66"
    }
end

-- Abstract out the highlighting logic so colorschemes only provide the palette
function M.apply_highlights(name, palette)
    vim.cmd("highlight clear")
    if vim.fn.exists("syntax_on") == 1 then
        vim.cmd("syntax reset")
    end
    vim.g.colors_name = name
    M.register_palette(palette)

    local highlights = {
        Normal       = { fg = palette.fg, bg = "NONE" },
        NormalNC     = { fg = palette.fg, bg = "NONE" },
        CursorLine   = { bg = palette.bg_highlight },
        CursorColumn = { bg = palette.bg_highlight },
        ColorColumn  = { bg = palette.bg_highlight },
        LineNr       = { fg = palette.fg_alt, bg = "NONE" },
        CursorLineNr = { fg = palette.primary, bg = "NONE", bold = true },
        SignColumn   = { bg = "NONE" },
        FoldColumn   = { fg = palette.fg_alt, bg = "NONE" },
        Folded       = { fg = palette.info, bg = palette.bg_alt },
        VertSplit    = { fg = palette.bg_highlight },
        WinSeparator = { fg = palette.bg_highlight },
        StatusLine   = { fg = palette.fg, bg = palette.bg_alt },
        StatusLineNC = { fg = palette.fg_alt, bg = palette.bg_alt },
        Visual       = { bg = palette.bg_highlight },
        VisualNOS    = { bg = palette.bg_highlight },
        Search       = { fg = palette.bg, bg = palette.primary },
        IncSearch    = { fg = palette.bg, bg = palette.secondary },
        NormalFloat  = { bg = "NONE" },
        FloatBorder  = { fg = palette.bg_highlight, bg = "NONE" },
        MatchParen   = { fg = palette.secondary, bold = true },
        Question     = { fg = palette.info },
        ModeMsg      = { fg = palette.fg, bold = true },
        MoreMsg      = { fg = palette.info },
        ErrorMsg     = { fg = palette.error, bold = true },
        WarningMsg   = { fg = palette.warning },
        Directory    = { fg = palette.info },
        Title        = { fg = palette.primary, bold = true },
        NonText      = { fg = palette.bg_highlight },
        SpecialKey   = { fg = palette.bg_highlight },
        Conceal      = { fg = palette.fg_alt },
        Pmenu        = { fg = palette.fg, bg = palette.bg_alt },
        PmenuSel     = { fg = palette.bg, bg = palette.info },
        PmenuSbar    = { bg = palette.bg_highlight },
        PmenuThumb   = { fg = palette.fg_alt },

        Comment        = { fg = palette.fg_alt, italic = true },
        Constant       = { fg = palette.warning },
        String         = { fg = palette.hint },
        Character      = { fg = palette.hint },
        Number         = { fg = palette.warning },
        Boolean        = { fg = palette.warning },
        Float          = { fg = palette.warning },
        Identifier     = { fg = palette.fg },
        Function       = { fg = palette.info },
        Statement      = { fg = palette.primary, bold = true },
        Conditional    = { fg = palette.error, bold = true },
        Repeat         = { fg = palette.error, bold = true },
        Label          = { fg = palette.info },
        Operator       = { fg = palette.primary },
        Keyword        = { fg = palette.primary, bold = true },
        Exception      = { fg = palette.error },
        PreProc        = { fg = palette.secondary },
        Include        = { fg = palette.info },
        Define         = { fg = palette.primary },
        Macro          = { fg = palette.secondary },
        PreCondit      = { fg = palette.secondary },
        Type           = { fg = palette.secondary },
        StorageClass   = { fg = palette.primary },
        Structure      = { fg = palette.primary },
        Typedef        = { fg = palette.secondary },
        Special        = { fg = palette.secondary },
        SpecialChar    = { fg = palette.secondary },
        Tag            = { fg = palette.info },
        Delimiter      = { fg = palette.fg_alt },
        SpecialComment = { fg = palette.fg_alt, italic = true },
        Debug          = { fg = palette.error },
        Underlined     = { underline = true },
        Ignore         = { fg = palette.bg_highlight },
        Error          = { fg = palette.error, bold = true },
        Todo           = { fg = palette.bg, bg = palette.primary, bold = true },

        ["@variable"] = { fg = palette.fg },
        ["@function"] = { fg = palette.info },
        ["@keyword"]  = { fg = palette.primary, bold = true },
        ["@type"]     = { fg = palette.secondary },
        ["@string"]   = { fg = palette.hint },
        ["@constant"] = { fg = palette.warning },
        ["@operator"] = { fg = palette.primary },
        ["@comment"]  = { fg = palette.fg_alt, italic = true },

        DiagnosticError = { fg = palette.error },
        DiagnosticWarn  = { fg = palette.warning },
        DiagnosticInfo  = { fg = palette.info },
        DiagnosticHint  = { fg = palette.hint },

        NeonYellow = { fg = palette.primary },
        NeonCyan   = { fg = palette.info },
        NeonGreen  = { fg = palette.hint },
    }

    for group, hl in pairs(highlights) do
        vim.api.nvim_set_hl(0, group, hl)
    end
end

local function apply_theme(os_theme)
    local target = os_theme == "light" and "moonchrome_light" or "moonchrome_dark"
    if vim.g.colors_name ~= target then
        vim.cmd("colorscheme " .. target)
    end
    if vim.o.background ~= os_theme then
        vim.o.background = os_theme
    end
end

local function check_os_theme_async()
    local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
    if not is_windows then return end

    vim.system({
        'C:\\Windows\\System32\\reg.exe', 'query',
        'HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize',
        '/v', 'AppsUseLightTheme'
    }, { text = true }, function(obj)
        if obj.code == 0 then
            local is_light = obj.stdout:match("REG_DWORD%s+0x1") ~= nil
            local os_theme = is_light and "light" or "dark"

            vim.schedule(function()
                if M._os_registry_theme == nil then
                    M._os_registry_theme = os_theme
                    if vim.g.colors_name == nil then
                        apply_theme(os_theme)
                    end
                    return
                end

                if os_theme ~= M._os_registry_theme then
                    M._os_registry_theme = os_theme
                    apply_theme(os_theme)
                end
            end)
        end
    end)
end

function M.setup(opts)
    opts = opts or {}
    
    if opts.sync_with_os then
        check_os_theme_async()
        M._timer = (vim.uv or vim.loop).new_timer()
        M._timer:start(3000, 3000, check_os_theme_async)
    end

    vim.keymap.set("n", "<leader>T", function()
        if vim.g.colors_name == "moonchrome_dark" then
            apply_theme("light")
        else
            apply_theme("dark")
        end
    end, { desc = "Toggle light/dark theme" })
end

return M
