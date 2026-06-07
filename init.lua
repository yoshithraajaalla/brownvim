-- ─────────────────────────────────────────────────────────────────────────────
-- 0. WINDOWS DETECTION & NATIVE PATH HANDLING
-- ─────────────────────────────────────────────────────────────────────────────
vim.env.CC = "gcc"
vim.env.CXX = "g++"
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

-- Force native Windows, never use WSL
if is_windows then
    vim.fn.setenv("SHELL", "pwsh.exe")
    vim.fn.setenv("TERM", "")
    -- Disable git operations that might invoke WSL
    vim.fn.setenv("GIT_TERMINAL_PROMPT", "0")
end

-- ─────────────────────────────────────────────────────────────────────────────
-- 0.5 VERSION DETECTION
-- ─────────────────────────────────────────────────────────────────────────────
local has_v012           = vim.fn.has("nvim-0.12") == 1

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
opt.termguicolors        = true -- true-colour support (required by themes)
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
-- NOTE: opt.lazyredraw was removed in Neovim 0.10+ (causes errors on 0.12)
opt.synmaxcol            = 300 -- Syntax cap for long lines
opt.completeopt          = "menuone,noinsert,noselect,fuzzy,popup"
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
            local function setup_lualine()
                local c = require("core.theme").palette()
                
                local custom_theme = {
                    normal   = { a = { fg = c.bg, bg = c.primary, gui = "bold" }, b = { fg = c.fg, bg = c.bg_alt }, c = { fg = c.fg, bg = c.bg_alt } },
                    insert   = { a = { fg = c.bg, bg = c.hint, gui = "bold" }, b = { fg = c.fg, bg = c.bg_alt }, c = { fg = c.fg, bg = c.bg_alt } },
                    visual   = { a = { fg = c.bg, bg = c.warning, gui = "bold" }, b = { fg = c.fg, bg = c.bg_alt }, c = { fg = c.fg, bg = c.bg_alt } },
                    replace  = { a = { fg = c.bg, bg = c.error, gui = "bold" }, b = { fg = c.fg, bg = c.bg_alt }, c = { fg = c.fg, bg = c.bg_alt } },
                    command  = { a = { fg = c.bg, bg = c.info, gui = "bold" }, b = { fg = c.fg, bg = c.bg_alt }, c = { fg = c.fg, bg = c.bg_alt } },
                    inactive = { a = { fg = c.fg, bg = c.bg_alt }, b = { fg = c.fg, bg = c.bg_alt }, c = { fg = c.fg, bg = c.bg_alt } },
                }

                require("lualine").setup({
                    options = {
                        theme                = custom_theme,
                        component_separators = { left = "│", right = "│" },
                        section_separators   = { left = "", right = "" },
                        globalstatus         = true,
                    },
                    sections = {
                        lualine_a = { "mode" },
                        lualine_b = { "branch", "diff", "diagnostics" },
                        lualine_c = { { "filename", path = 1, shorting_target = 40 } },
                        lualine_x = {
                            {
                                function()
                                    local total_lines = vim.api.nvim_buf_line_count(0)
                                    return string.format("Ln %d", total_lines)
                                end,
                                color = { fg = c.fg, bg = c.bg_alt },
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
            end

            setup_lualine()

            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("lualine_colorscheme_sync", { clear = true }),
                callback = function()
                    setup_lualine()
                end,
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
        branch = "main", -- master branch is frozen; main is required for 0.12+
        build  = ":TSUpdate",
        lazy   = false,
        config = function()
            -- Ensure the parser install directory is in runtimepath
            local install_dir = vim.fn.stdpath("data") .. "/site"
            if not vim.tbl_contains(vim.opt.rtp:get(), install_dir) then
                vim.opt.rtp:prepend(install_dir)
            end

            local ok, ts = pcall(require, "nvim-treesitter")
            if ok and ts.install then
                -- Force use of gcc (installed via scoop) instead of MSVC (cl.exe)
                require("nvim-treesitter.install").compilers = { "gcc" }

                -- New API (main branch): handles parser installation;
                -- highlight/indent are built-in via vim.treesitter
                ts.install({
                    "lua", "python", "go", "bash", "json", "yaml", "toml",
                    "markdown", "markdown_inline", "dockerfile", "regex",
                })
            else
                -- Legacy API fallback
                require("nvim-treesitter.configs").setup({
                    ensure_installed = {
                        "lua", "python", "go", "bash", "json", "yaml", "toml",
                        "markdown", "markdown_inline", "dockerfile", "regex",
                    },
                    auto_install     = true,
                    highlight        = { enable = true, additional_vim_regex_highlighting = false },
                    indent           = { enable = true },
                })
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
            require("core.language").init_conform()
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
            require("mason-lspconfig").setup({})
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("core.language").init_mason()
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "williamboman/mason-lspconfig.nvim" },
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

    -- RENDER-MARKDOWN.NVIM
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
        opts = {
            html  = { enabled = false },
            latex = { enabled = false },
            yaml  = { enabled = false },
        },
    },

}, {
    ui               = { border = "rounded" },
    rocks            = { enabled = false },
    checker          = { enabled = false },
    change_detection = { notify = false },
    performance      = { rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" } } },
})

-- ─────────────────────────────────────────────────────────────────────────────
-- 4.2. AUTOMATIC SYSTEM THEME SYNC
-- ─────────────────────────────────────────────────────────────────────────────
require("core.theme").setup({ sync_with_os = true })

require("core.language").setup({
    python = { 
        lsp = { name = "pyright", settings = { python = { analysis = { typeCheckingMode = "basic", autoSearchPaths = true, useLibraryCodeForTypes = true } } } }, 
        formatters = { "black" },
        tools = { "isort" }
    },
    go = { 
        lsp = { name = "gopls", settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } } }, 
        formatters = { "gofmt" } 
    },
    lua = { 
        lsp = { name = "lua_ls", settings = { Lua = { runtime = { version = "LuaJIT" }, workspace = { checkThirdParty = false, library = vim.api.nvim_list_runtime_paths() }, diagnostics = { globals = { "vim" } }, telemetry = { enable = false } } } }, 
        formatters = { "stylua" } 
    },
    rust = { 
        lsp = "rust_analyzer"
    },
})

-- ─────────────────────────────────────────────────────────────────────────────
-- 4.5. LSP CONFIGURATION (NATIVE 0.11+)
-- ─────────────────────────────────────────────────────────────────────────────
local capabilities = vim.lsp.protocol.make_client_capabilities()
local border = "rounded"

-- ENHANCED: Better diagnostic display with 0.12+ features
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
    -- NEW in 0.12: built-in virtual_lines (like lsp_lines plugin)
    -- current_line = true shows virtual lines only for the cursor line (less noisy)
    virtual_lines    = has_v012 and { current_line = true } or false,
    float            = {
        border = border,
        source = true,
        max_width = 60,
        -- 0.12+: severity-aware prefix icons in float windows
        prefix = has_v012 and function(diag, i, total)
            local icons = {
                [vim.diagnostic.severity.ERROR] = "● ",
                [vim.diagnostic.severity.WARN]  = "● ",
                [vim.diagnostic.severity.HINT]  = "◆ ",
                [vim.diagnostic.severity.INFO]  = "◆ ",
            }
            local hls = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticError",
                [vim.diagnostic.severity.WARN]  = "DiagnosticWarn",
                [vim.diagnostic.severity.HINT]  = "DiagnosticHint",
                [vim.diagnostic.severity.INFO]  = "DiagnosticInfo",
            }
            return (icons[diag.severity] or "● "), (hls[diag.severity] or "DiagnosticInfo")
        end or nil,
    },
})

vim.api.nvim_create_autocmd("LspAttach", {
    group    = vim.api.nvim_create_augroup("brownnvim_lsp_attach", { clear = true }),
    callback = function(event)
        local bufnr  = event.buf
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Native completion (replaces nvim-cmp)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        end

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
        m("[d", function() vim.diagnostic.jump({ count = -1, float = { border = border } }) end, "Prev diagnostic")
        m("]d", function() vim.diagnostic.jump({ count = 1, float = { border = border } }) end, "Next diagnostic")
        m("<leader>lf", function() require("conform").format({ async = true, lsp_fallback = true }) end, "Format file")
        m("<leader>la", vim.diagnostic.setloclist, "Show all diagnostics")

        -- Snippet navigation (replaces LuaSnip Tab/S-Tab)
        vim.keymap.set({ "i", "s" }, "<Tab>", function()
            if vim.snippet.active({ direction = 1 }) then
                return "<cmd>lua vim.snippet.jump(1)<cr>"
            else
                return "<Tab>"
            end
        end, { buffer = bufnr, expr = true, desc = "Snippet: next tabstop or Tab" })

        vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
            if vim.snippet.active({ direction = -1 }) then
                return "<cmd>lua vim.snippet.jump(-1)<cr>"
            else
                return "<S-Tab>"
            end
        end, { buffer = bufnr, expr = true, desc = "Snippet: prev tabstop or S-Tab" })

        -- Confirm completion with CR
        vim.keymap.set("i", "<CR>", function()
            if vim.fn.pumvisible() == 1 then
                return "<C-y>"
            else
                return "<CR>"
            end
        end, { buffer = bufnr, expr = true, desc = "Confirm completion or Enter" })
    end,
})

-- SERVER CONFIGURATIONS (0.11+ API)
require("core.language").init_lsp()


-- ─────────────────────────────────────────────────────────────────────────────
-- 5. DEEP MODULES
-- ─────────────────────────────────────────────────────────────────────────────
require('core.terminal').setup()
require('core.dashboard').setup()
require('core.keymaps').setup()

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
