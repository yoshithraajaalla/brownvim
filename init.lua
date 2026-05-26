-- ─────────────────────────────────────────────────────────────────────────────
-- 0. WINDOWS DETECTION & NATIVE PATH HANDLING
-- ─────────────────────────────────────────────────────────────────────────────
local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

-- Force native Windows, never use WSL
if is_windows then
    vim.fn.setenv("SHELL", "pwsh.exe")
    vim.fn.setenv("TERM", "")
    -- Disable git operations that might invoke WSL
    vim.fn.setenv("GIT_TERMINAL_PROMPT", "0")
end

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. LEADER & NETRW
-- ─────────────────────────────────────────────────────────────────────────────
vim.g.mapleader          = " "
vim.g.maplocalleader     = " "
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- ─────────────────────────────────────────────────────────────────────────────
-- 2. OPTIONS
-- ─────────────────────────────────────────────────────────────────────────────
local opt                = vim.opt

-- Line numbers & Indentation
opt.number               = true
opt.relativenumber       = true
opt.tabstop              = 4
opt.shiftwidth           = 4
opt.expandtab            = true
opt.smartindent          = true

-- Visuals
opt.wrap                 = false
opt.termguicolors        = true -- true-colour support (required by gruvbox)
opt.cursorline           = true
opt.signcolumn           = "yes"
opt.showmode             = false -- lualine handles this
opt.pumheight            = 10
opt.cmdheight            = 1
opt.conceallevel         = 0
opt.fileencoding         = "utf-8"
opt.pumblend             = 0 -- no opacity tint on popup menus
opt.winblend             = 0 -- no opacity tint on floating windows

-- Scrolling & Splits
opt.scrolloff            = 10 -- increased from 8 for more breathing room
opt.sidescrolloff        = 8
opt.splitright           = true
opt.splitbelow           = true

-- Search & Performance
opt.hlsearch             = true
opt.incsearch            = true
opt.ignorecase           = true
opt.smartcase            = true
opt.updatetime           = 250
opt.timeoutlen           = 300

-- Quality of life
opt.mouse                = "a"
opt.clipboard            = "unnamedplus" -- sync with system clipboard
opt.undofile             = true          -- persistent undo
opt.showmatch            = true          -- Highlight matching brackets
opt.matchtime            = 2
opt.lazyredraw           = true          -- Speed up macros
opt.synmaxcol            = 300           -- Syntax cap for long lines
opt.completeopt          = "menuone,noinsert,noselect"
opt.backup               = false
opt.writebackup          = false
opt.swapfile             = false
opt.autochdir            = false -- Keep original working dir
opt.selection            = "exclusive"
opt.iskeyword:append("-")        -- Hyphens as word chars

-- ─────────────────────────────────────────────────────────────────────────────
-- 3. LAZY BOOTSTRAP
-- ─────────────────────────────────────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ─────────────────────────────────────────────────────────────────────────────
-- 4. PLUGINS
-- ─────────────────────────────────────────────────────────────────────────────
require("lazy").setup({

    -- COLORSCHEME
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        lazy     = false,
        config   = function()
            -- FIX: Set highlight groups BEFORE colorscheme to ensure visibility
            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("neon_circuit_custom", { clear = true }),
                pattern = "*",
                callback = function()
                    -- Core UI
                    vim.api.nvim_set_hl(0, "Normal", { fg = "#D1C5C0", bg = "NONE" })
                    vim.api.nvim_set_hl(0, "LineNr", { fg = "#6F747C", bg = "NONE" })
                    vim.api.nvim_set_hl(0, "CursorLine", { bg = "#31343F" })
                    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFD300", bg = "NONE", bold = true })
                    vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
                    vim.api.nvim_set_hl(0, "Visual", { bg = "#3B3F4A" })
                    vim.api.nvim_set_hl(0, "Search", { fg = "#1E2028", bg = "#FFD300" })
                    vim.api.nvim_set_hl(0, "IncSearch", { fg = "#1E2028", bg = "#37EBF3" })
                    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
                    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#3B3F4A", bg = "NONE" })

                    -- Indent Blankline
                    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3B3F4A", nocombine = true })
                    vim.api.nvim_set_hl(0, "IblScope", { fg = "#37EBF3", nocombine = true })

                    -- Syntax Highlighting (Treesitter overrides)
                    vim.api.nvim_set_hl(0, "@keyword", { fg = "#FFD300", bold = true })
                    vim.api.nvim_set_hl(0, "@function", { fg = "#37EBF3" })
                    vim.api.nvim_set_hl(0, "@type", { fg = "#7EF9FF" })
                    vim.api.nvim_set_hl(0, "@string", { fg = "#D1C5C0" })
                    vim.api.nvim_set_hl(0, "@constant", { fg = "#FFB800" })
                    vim.api.nvim_set_hl(0, "@operator", { fg = "#FFD300" })
                    vim.api.nvim_set_hl(0, "@comment", { fg = "#6F747C", italic = true })

                    -- Diagnostics
                    vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#DB2813" })
                    vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#FFD300" })
                    vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#37EBF3" })
                    vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#8BC34A" })

                    -- Dashboard helper groups
                    vim.api.nvim_set_hl(0, "NeonYellow", { fg = "#FFD300" })
                    vim.api.nvim_set_hl(0, "NeonCyan", { fg = "#37EBF3" })
                    vim.api.nvim_set_hl(0, "NeonGreen", { fg = "#8BC34A" })
                end,
            })
            require("gruvbox").setup({
                transparent_mode = true,
                contrast         = "hard",
                italic           = {
                    strings   = false,
                    emphasis  = true,
                    comments  = true,
                    operators = false,
                    folds     = true,
                },
            })
            vim.o.background = "dark"
            vim.cmd("colorscheme gruvbox")

            -- FIX: Ensure line numbers are visible on transparent background
            vim.api.nvim_set_hl(0, "LineNr", { fg = "#7c6f64", bg = "NONE" })
            vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#fabd2f", bg = "NONE", bold = true })
            vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
        end,
    },

    -- CORE & UTILS
    { "nvim-lua/plenary.nvim", lazy = true },
    { "numToStr/comment.nvim", lazy = true },

    -- HARPOON 2 (Thanks, theprimeagen!)
    {
        "ThePrimeagen/harpoon",
        branch       = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys         = {
            { "<leader>a", desc = "Harpoon: add file" },
            { "<C-e>",     desc = "Harpoon: menu" },
            { "<leader>1", desc = "Harpoon: file 1" },
            { "<leader>2", desc = "Harpoon: file 2" },
            { "<leader>3", desc = "Harpoon: file 3" },
            { "<leader>4", desc = "Harpoon: file 4" },
        },
        config       = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            local m = vim.keymap.set
            m("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: add file" })
            m("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: menu" })
            m("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon: file 1" })
            m("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon: file 2" })
            m("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon: file 3" })
            m("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon: file 4" })
        end,
    },

    -- LUALINE (Modern statusline)
    {
        "nvim-lualine/lualine.nvim",
        event  = "VeryLazy",
        config = function()
            local c = {
                black  = "#1E2028", -- Deep background (bg0)
                white  = "#F2ECE8", -- Bright foreground (fg0)
                yellow = "#FFD300", -- Primary Accent
                green  = "#8BC34A", -- Success / Insert mode indicator
                orange = "#FFB800", -- Amber / Visual mode indicator
                red    = "#DB2813", -- Danger / Replace mode indicator
                blue   = "#37EBF3", -- Cyan / Command mode indicator
                mid    = "#31343F", -- Secondary surface (bg2)
            }

            local theme = {
                normal   = { a = { fg = c.black, bg = c.yellow, gui = "bold" }, b = { fg = c.white, bg = c.mid }, c = { fg = c.white, bg = c.mid } },
                insert   = { a = { fg = c.black, bg = c.green, gui = "bold" }, b = { fg = c.white, bg = c.mid }, c = { fg = c.white, bg = c.mid } },
                visual   = { a = { fg = c.black, bg = c.orange, gui = "bold" }, b = { fg = c.white, bg = c.mid }, c = { fg = c.white, bg = c.mid } },
                replace  = { a = { fg = c.black, bg = c.red, gui = "bold" }, b = { fg = c.white, bg = c.mid }, c = { fg = c.white, bg = c.mid } },
                command  = { a = { fg = c.black, bg = c.blue, gui = "bold" }, b = { fg = c.white, bg = c.mid }, c = { fg = c.white, bg = c.mid } },
                inactive = { a = { fg = c.white, bg = c.mid }, b = { fg = c.white, bg = c.mid }, c = { fg = c.white, bg = c.mid } },
            }

            require("lualine").setup({
                options = {
                    theme                = theme,
                    component_separators = { left = "│", right = "│" },
                    section_separators   = { left = "", right = "" },
                    globalstatus         = true,
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { { "filename", path = 1, shorting_target = 40 } },
                    -- ENHANCED: Add line count + modern source indicators
                    lualine_x = {
                        {
                            function()
                                local total_lines = vim.api.nvim_buf_line_count(0)
                                return string.format("Ln %d", total_lines)
                            end,
                            color = { fg = c.white, bg = c.mid },
                        },
                        { "encoding",               icons_enabled = false },
                        { function() return "" end, padding = { left = 1, right = 1 } },
                        "filetype",
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_c = { { "filename", path = 1 } },
                    lualine_x = { "location" },
                },
            })
        end,
    },
    -- SMOOTH CURSOR & SCROLLING
    {
        "sphamba/smear-cursor.nvim",
        event = "VimEnter",
        opts = {
            stiffness = 0.8,
            trailing_stiffness = 0.6,
            damping = 0.95,
            damping_insert_mode = 0.95,
        },
    },
    {
        "declancm/cinnamon.nvim",
        opts = {
            options = {
                mode = "cursor",
                delay = 5,
                step_size = { vertical = 1, horizontal = 1 },
            },
            keymaps = { basic = true, extra = true },
        },
    },
    -- TREESITTER (Modern syntax highlighting & indent)
    {
        "nvim-treesitter/nvim-treesitter",
        build  = ":TSUpdate",
        lazy   = false,
        config = function()
            local ok, ts = pcall(require, "nvim-treesitter")
            local opts = {
                ensure_installed = {
                    "lua", "python", "go", "bash", "json", "yaml", "toml",
                    "markdown", "markdown_inline", "dockerfile", "regex",
                },
                auto_install     = true,
                highlight        = { enable = true, additional_vim_regex_highlighting = false },
                indent           = { enable = true },
            }

            if ok and ts.setup then
                ts.setup(opts)
            else
                require("nvim-treesitter.configs").setup(opts)
            end
        end,
    },

    -- TELESCOPE (Fuzzy finder)
    {
        "nvim-telescope/telescope.nvim",
        cmd          = "Telescope",
        keys         = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>",                desc = "Find files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>",                 desc = "Live grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                  desc = "Recent files" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>",                 desc = "Help tags" },
            { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search current buffer" },
        },
        dependencies = { "nvim-lua/plenary.nvim" },
        config       = function()
            require("telescope").setup({
                defaults = {
                    prompt_prefix        = "   ",
                    selection_caret      = "  ",
                    layout_strategy      = "horizontal",
                    layout_config        = { prompt_position = "top", preview_width = 0.55 },
                    sorting_strategy     = "ascending",
                    winblend             = 0,
                    file_ignore_patterns = { "node_modules", ".git/", "__pycache__", "%.pyc" },
                },
            })
        end,
    },

    -- AUTO-PAIRS
    {
        "windwp/nvim-autopairs",
        event  = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({ check_ts = true })
        end,
    },

    -- GITSIGNS (Git integration)
    {
        "lewis6991/gitsigns.nvim",
        event  = { "BufReadPre", "BufNewFile" },
        config = function()
            require("gitsigns").setup({
                signs = {
                    add          = { text = "▎" },
                    change       = { text = "▎" },
                    delete       = { text = "" },
                    topdelete    = { text = "" },
                    changedelete = { text = "▎" },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    local m  = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                    end
                    m("n", "]h", gs.next_hunk, "Next hunk")
                    m("n", "[h", gs.prev_hunk, "Prev hunk")
                    m("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
                    m("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
                    m("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
                    m("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
                    m("n", "<leader>hd", gs.diffthis, "Diff this")
                end,
            })
        end,
    },

    -- CONFORM (Code Formatter)
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local conform = require("conform")

            conform.formatters.isort = {
                inherit = true,
                args = { "--profile", "black", "-" },
            }

            conform.setup({
                formatters_by_ft = {
                    python = { "black" },
                    lua = { "stylua" },
                    go = { "gofmt" },
                },
                format_on_save = {
                    timeout_ms = 5000,
                    lsp_fallback = true,
                },
            })
        end,
    },

    -- MASON & LSP CONFIG
    {
        "williamboman/mason.nvim",
        cmd    = "Mason",
        build  = ":MasonUpdate",
        config = function()
            require("mason").setup({ ui = { border = "rounded" } })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "gopls", "lua_ls" },
                automatic_installation = true,
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = { "black", "isort" },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local border = "rounded"

            -- ENHANCED: Better diagnostic display with format function
            vim.diagnostic.config({
                virtual_text     = {
                    prefix = "●",
                    format = function(diag)
                        return string.format("[%s] %s", diag.code or "E", diag.message)
                    end
                },
                signs            = true,
                underline        = true,
                update_in_insert = false,
                severity_sort    = true,
                float            = { border = border, source = true, max_width = 60 },
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group    = vim.api.nvim_create_augroup("brownnvim_lsp_attach", { clear = true }),
                callback = function(event)
                    local bufnr = event.buf
                    local m = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
                    end
                    m("gd", vim.lsp.buf.definition, "Go to definition")
                    m("gD", vim.lsp.buf.declaration, "Go to declaration")
                    m("gi", vim.lsp.buf.implementation, "Go to implementation")
                    m("gr", vim.lsp.buf.references, "References")
                    m("K", function() vim.lsp.buf.hover({ border = border }) end, "Hover docs")
                    m("<C-s>", function() vim.lsp.buf.signature_help({ border = border }) end, "Signature help")
                    m("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                    m("<leader>ca", vim.lsp.buf.code_action, "Code action")
                    m("<leader>D", vim.lsp.buf.type_definition, "Type definition")
                    m("<leader>l", vim.diagnostic.open_float, "Show diagnostics")
                    -- FIX: Use vim.diagnostic.jump() instead of deprecated goto_prev/next
                    m("[d", function() vim.diagnostic.jump({ count = -1, float = { border = border } }) end,
                        "Prev diagnostic")
                    m("]d", function() vim.diagnostic.jump({ count = 1, float = { border = border } }) end,
                        "Next diagnostic")
                    m("<leader>lf", function() require("conform").format({ async = true, lsp_fallback = true }) end,
                        "Format file")
                    m("<leader>la", vim.diagnostic.setloclist, "Show all diagnostics")
                end,
            })

            -- SERVER CONFIGURATIONS (0.11+ API)
            vim.lsp.config("pyright", {
                capabilities = capabilities,
                settings = { python = { analysis = { typeCheckingMode = "basic", autoSearchPaths = true, useLibraryCodeForTypes = true } } },
            })

            vim.lsp.config("gopls", {
                capabilities = capabilities,
                settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
            })

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        workspace = { checkThirdParty = false, library = vim.api.nvim_list_runtime_paths() },
                        diagnostics = { globals = { "vim" } },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.lsp.enable({ "pyright", "gopls", "lua_ls" })
        end,
    },

    -- NVIM-TREE (File explorer)
    {
        "nvim-tree/nvim-tree.lua",
        version      = "*",
        lazy         = true,
        cmd          = { "NvimTreeToggle", "NvimTreeFocus" },
        keys         = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File tree: toggle" },
            { "<leader>E", "<cmd>NvimTreeFocus<cr>",  desc = "File tree: focus" },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config       = function()
            vim.g.loaded_netrw       = 1
            vim.g.loaded_netrwPlugin = 1

            require("nvim-tree").setup({
                renderer           = {
                    group_empty    = true,
                    highlight_git  = true,
                    indent_markers = { enable = true },
                    icons          = {
                        show = { git = true, file = true, folder = true },
                        glyphs = { git = { unstaged = "✦", staged = "✔", untracked = "★", deleted = "✘", ignored = "◌" } },
                    },
                },
                hijack_cursor      = true,
                sync_root_with_cwd = true,
                respect_buf_cwd    = true,
                git                = { enable = true, ignore = false, timeout = 400 },
                diagnostics        = { enable = true, show_on_dirs = true, icons = { error = "●", warning = "●", hint = "●", info = "●" } },
                view               = { width = 32, side = "left", preserve_window_proportions = true },
                filters            = { dotfiles = false, custom = { "^.git$" } },
                actions            = { open_file = { quit_on_open = false, resize_window = false, window_picker = { enable = true } } },
                on_attach          = function(bufnr)
                    local api = require("nvim-tree.api")
                    local function opts(desc)
                        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                    end
                    api.config.mappings.default_on_attach(bufnr)
                    vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
                    vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
                end,
            })
        end,
    },

    -- NVIM-CMP (Completion engine - modern with source hints)
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp     = require("cmp") --[[@as any]]
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            local src_icons = { nvim_lsp = "󰒋 ", luasnip = " ", buffer = "󰘨 ", path = " " }

            cmp.setup({
                snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"]     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"]     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"]     = cmp.mapping.abort(),
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"]     = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"]   = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then ---@diagnostic disable-line: redundant-parameter
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" }, { name = "path" },
                }),
                window = {
                    completion    = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                -- ENHANCED: Better formatting with source context
                formatting = {
                    format = function(entry, item)
                        item.menu = src_icons[entry.source.name] or ""
                        -- Add subtle source label for clarity
                        if entry.source.name == "nvim_lsp" then
                            item.menu = item.menu .. " (lsp)"
                        elseif entry.source.name == "luasnip" then
                            item.menu = item.menu .. " (snip)"
                        end
                        return item
                    end,
                },
            })
        end,
    },

    -- RENDER-MARKDOWN.NVIM
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
        opts = {},
    },

}, {
    ui               = { border = "rounded" },
    checker          = { enabled = false },
    change_detection = { notify = false },
    performance      = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
})

-- ─────────────────────────────────────────────────────────────────────────────
-- 5. FLOATING TERMINAL
-- ─────────────────────────────────────────────────────────────────────────────
local _term_buf = nil
local _term_win = nil
local _shell = (vim.fn.executable("pwsh") == 1) and "pwsh.exe" or "powershell.exe"

local function toggle_float_term()
    if _term_win and vim.api.nvim_win_is_valid(_term_win) then
        vim.api.nvim_win_hide(_term_win)
        _term_win = nil
        return
    end

    local cols, rows = vim.o.columns, vim.o.lines
    local width, height = math.floor(cols * 0.85), math.floor(rows * 0.80)
    local col, row = math.floor((cols - width) / 2), math.floor((rows - height) / 2)

    if not (_term_buf and vim.api.nvim_buf_is_valid(_term_buf)) then
        _term_buf = vim.api.nvim_create_buf(false, true)
    end

    _term_win = vim.api.nvim_open_win(_term_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal",
        border = "rounded",
        title = "  " .. _shell .. " ",
        title_pos = "center",
    })

    if vim.bo[_term_buf].buftype ~= "terminal" then
        vim.fn.jobstart(_shell, { term = true })
        vim.bo[_term_buf].buflisted = false
    end

    vim.cmd("startinsert")
end

vim.keymap.set({ "n", "t" }, "<leader>t", toggle_float_term, { desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ─────────────────────────────────────────────────────────────────────────────
-- 6. STARTUP DASHBOARD
-- ─────────────────────────────────────────────────────────────────────────────
local function open_dashboard()
    if vim.fn.argc() > 0 then return end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(buf)

    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].buflisted = false
    vim.bo[buf].swapfile = false
    vim.bo[buf].modifiable = true

    local header = {
        "",
        "  ██████╗ ██████╗  ██████╗ ██╗    ██╗███╗   ██╗██╗   ██╗██╗███╗   ███╗ ",
        "  ██╔══██╗██╔══██╗██╔═══██╗██║    ██║████╗  ██║██║   ██║██║████╗ ████║ ",
        "  ██████╔╝██████╔╝██║   ██║██║ █╗ ██║██╔██╗ ██║██║   ██║██║██╔████╔██║ ",
        "  ██╔══██╗██╔══██╗██║   ██║██║███╗██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██████╔╝██║  ██║╚██████╔╝╚███╔███╔╝██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "",
        "  Minimal. Intentional. Fast.                                          ",
        "",
    }

    local buttons = {
        "  [f]  Find File          <leader> f f",
        "  [g]  Live Grep          <leader> f g",
        "  [r]  Recent Files       <leader> f r",
        "  [b]  Browse Buffers     <leader> f b",
        "  [n]  New File",
        "  [q]  Quit",
        "",
        "  [?]  Show all keymaps",
    }

    local content = {}
    for _, l in ipairs(header) do table.insert(content, l) end
    for _, l in ipairs(buttons) do table.insert(content, l) end

    local pad = math.max(0, math.floor((vim.o.lines - #content) / 2) - 2)
    local out = {}
    for _ = 1, pad do table.insert(out, "") end
    for _, l in ipairs(content) do table.insert(out, l) end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, out)
    vim.bo[buf].modifiable = false

    vim.api.nvim_set_option_value("number", false, { win = 0 })
    vim.api.nvim_set_option_value("relativenumber", false, { win = 0 })
    vim.api.nvim_set_option_value("signcolumn", "no", { win = 0 })
    vim.api.nvim_set_option_value("cursorline", false, { win = 0 })
    vim.api.nvim_set_option_value("foldcolumn", "0", { win = 0 })

    local ns = vim.api.nvim_create_namespace("dashboard_hl")
    local h  = pad

    for i = h + 1, h + 6 do vim.api.nvim_buf_set_extmark(buf, ns, i, 0, { line_hl_group = "NeonYellow" }) end
    vim.api.nvim_buf_set_extmark(buf, ns, h + 8, 0, { line_hl_group = "NeonCyan" })

    local btn_start = h + #header
    for i = btn_start, btn_start + #buttons - 1 do
        vim.api.nvim_buf_set_extmark(buf, ns, i, 0, { line_hl_group = "NeonGreen" })
    end

    local dk = function(key, action) vim.keymap.set("n", key, action, { buffer = buf, nowait = true, silent = true }) end
    dk("f", "<cmd>Telescope find_files<cr>")
    dk("g", "<cmd>Telescope live_grep<cr>")
    dk("r", "<cmd>Telescope oldfiles<cr>")
    dk("b", "<cmd>Telescope buffers<cr>")
    dk("n", "<cmd>enew<cr>")
    dk("q", "<cmd>qa<cr>")
    dk("?", "<cmd>Telescope keymaps<cr>")
end

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function() vim.schedule(open_dashboard) end,
    once = true,
})

-- FIX: Re-enable line numbers when entering normal buffers
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    group = vim.api.nvim_create_augroup("brownnvim_line_numbers", { clear = true }),
    callback = function(args)
        if vim.bo[args.buf].buftype == "" then
            vim.wo.number = true
            vim.wo.relativenumber = true
            vim.wo.signcolumn = "yes"
            vim.wo.cursorline = true
        end
    end,
})

-- ─────────────────────────────────────────────────────────────────────────────
-- 7. GENERAL KEYMAPS
-- ─────────────────────────────────────────────────────────────────────────────
local map = vim.keymap.set

-- Window & Buffer Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window ←" })
map("n", "<C-l>", "<C-w>l", { desc = "Window →" })
map("n", "<C-j>", "<C-w>j", { desc = "Window ↓" })
map("n", "<C-k>", "<C-w>k", { desc = "Window ↑" })
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Resize ↑" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Resize ↓" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Resize ←" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Resize →" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprev<cr>", { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Editing & Config
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear highlights" })
map("n", "<leader>w", function()
    require("conform").format({ async = true, lsp_fallback = true }, function()
        vim.cmd("w")
    end)
end, { desc = "Format and save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>q!<cr>", { desc = "Force Quit" })
map("n", "<leader>rc", function() vim.cmd("e " .. vim.fn.stdpath("config") .. "/init.lua") end, { desc = "Edit config" })
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Search current buffer" })
map("n", "<leader>ra", "<cmd>e#<cr>", { desc = "Toggle to alternate file" })
map("n", "<leader>cc", "<cmd>%yank<cr>", { desc = "Copy entire file" })
map("n", "<leader>s", "<cmd>normal! ggVG<cr>", { desc = "Select entire file" })

-- Visual Mode Enhancements
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Centred Jumps
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll ↓ (centred)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll ↑ (centred)" })
map("n", "n", "nzzzv", { desc = "Next match (centred)" })
map("n", "N", "Nzzzv", { desc = "Prev match (centred)" })

-- Black Hole Deletes (Prevents overriding clipboard)
map("x", "<leader>p", [["_dP]], { desc = "Paste without yank" })

local delete_maps = {
    ["d"]   = "Delete without yank",
    ["dd"]  = "Delete line without yank",
    ["D"]   = "Delete to end without yank",
    ["dw"]  = "Delete word without yank",
    ["db"]  = "Delete word back without yank",
    ["de"]  = "Delete to end of word without yank",
    ["d$"]  = "Delete to end of line without yank",
    ["d0"]  = "Delete to start of line without yank",
    ["d^"]  = "Delete to first non-blank without yank",
    ["diw"] = "Delete inner word without yank",
    ["diW"] = "Delete inner WORD without yank",
    ['di"'] = "Delete inside quotes without yank",
    ["di'"] = "Delete inside single quotes without yank",
    ["di("] = "Delete inside parentheses without yank",
    ["di)"] = "Delete inside parentheses without yank",
    ["dib"] = "Delete inside block without yank",
    ["di["] = "Delete inside brackets without yank",
    ["di]"] = "Delete inside brackets without yank",
    ["di{"] = "Delete inside braces without yank",
    ["di}"] = "Delete inside braces without yank",
    ["diB"] = "Delete inside Block without yank",
    ["di<"] = "Delete inside angle brackets without yank",
    ["di>"] = "Delete inside angle brackets without yank",
    ["dit"] = "Delete inside tag without yank",
    ["dip"] = "Delete inside paragraph without yank",
    ["daw"] = "Delete around word without yank",
    ["daW"] = "Delete around WORD without yank",
    ['da"'] = "Delete around quotes without yank",
    ["da'"] = "Delete around single quotes without yank",
    ["da("] = "Delete around parentheses without yank",
    ["da)"] = "Delete around parentheses without yank",
    ["dab"] = "Delete around block without yank",
    ["da["] = "Delete around brackets without yank",
    ["da]"] = "Delete around brackets without yank",
    ["da{"] = "Delete around braces without yank",
    ["da}"] = "Delete around braces without yank",
    ["daB"] = "Delete around Block without yank",
    ["da<"] = "Delete around angle brackets without yank",
    ["da>"] = "Delete around angle brackets without yank",
    ["dat"] = "Delete around tag without yank",
    ["dap"] = "Delete around paragraph without yank",
}

for key, description in pairs(delete_maps) do
    map("n", key, '"_' .. key, { desc = description })
end

map("v", "d", '"_d', { desc = "Delete without yank" })
map("v", "x", '"_x', { desc = "Delete char without yank" })
map("v", "X", '"_X', { desc = "Delete char before without yank" })

-- Cut operations (explicit yank)
map("n", "<leader>d", "d", { desc = "Cut (delete with yank)" })
map("n", "<leader>dd", "dd", { desc = "Cut line" })
map("n", "<leader>D", "D", { desc = "Cut to end of line" })
map("v", "<leader>d", "d", { desc = "Cut (delete with yank)" })

-- ─────────────────────────────────────────────────────────────────────────────
-- 8. AUTOCOMMANDS
-- ─────────────────────────────────────────────────────────────────────────────

-- FIX: vim.highlight → vim.hl (Neovim 0.11+)
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 }) end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark, lcount = vim.api.nvim_buf_get_mark(0, '"'), vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        local pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[%s/\s\+$//e]])
        vim.api.nvim_win_set_cursor(0, pos)
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern  = { "go" },
    callback = function()
        vim.bo.expandtab, vim.bo.tabstop, vim.bo.shiftwidth = false, 4, 4
    end,
})
