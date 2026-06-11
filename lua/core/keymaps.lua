local M = {}

function M.setup()
    local has_v012 = vim.fn.has("nvim-0.12") == 1

    local keymaps = {
        -- Window & Buffer Navigation
        { mode = "n", lhs = "<C-h>", rhs = "<C-w>h", desc = "Window ←" },
        { mode = "n", lhs = "<C-l>", rhs = "<C-w>l", desc = "Window →" },
        { mode = "n", lhs = "<C-j>", rhs = "<C-w>j", desc = "Window ↓" },
        { mode = "n", lhs = "<C-k>", rhs = "<C-w>k", desc = "Window ↑" },
        { mode = "n", lhs = "<C-Up>", rhs = "<cmd>resize +2<cr>", desc = "Resize ↑" },
        { mode = "n", lhs = "<C-Down>", rhs = "<cmd>resize -2<cr>", desc = "Resize ↓" },
        { mode = "n", lhs = "<C-Left>", rhs = "<cmd>vertical resize -2<cr>", desc = "Resize ←" },
        { mode = "n", lhs = "<C-Right>", rhs = "<cmd>vertical resize +2<cr>", desc = "Resize →" },
        { mode = "n", lhs = "<S-l>", rhs = "<cmd>bnext<cr>", desc = "Next buffer" },
        { mode = "n", lhs = "<S-h>", rhs = "<cmd>bprev<cr>", desc = "Prev buffer" },
        { mode = "n", lhs = "<leader>bd", rhs = "<cmd>bdelete<cr>", desc = "Delete buffer" },

        -- Editing & Config
        { mode = "n", lhs = "<Esc>", rhs = "<cmd>nohlsearch<cr>", desc = "Clear highlights" },
        { mode = "n", lhs = "<leader>w", rhs = function()
            require("conform").format({ async = true, lsp_fallback = true }, function() vim.cmd("w") end)
        end, desc = "Format and save" },
        { mode = "n", lhs = "<leader>q", rhs = "<cmd>q<cr>", desc = "Quit" },
        { mode = "n", lhs = "<leader>Q", rhs = "<cmd>q!<cr>", desc = "Force Quit" },
        { mode = "n", lhs = "<leader>rc", rhs = function() vim.cmd("e " .. vim.fn.stdpath("config") .. "/init.lua") end, desc = "Edit config" },
        { mode = "n", lhs = "<leader>/", rhs = "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search current buffer" },
        { mode = "n", lhs = "<leader>ra", rhs = "<cmd>e#<cr>", desc = "Toggle to alternate file" },
        { mode = "n", lhs = "<leader>cc", rhs = "<cmd>%yank<cr>", desc = "Copy entire file" },
        { mode = "n", lhs = "<leader>s", rhs = "<cmd>normal! ggVG<cr>", desc = "Select entire file" },

        -- Visual Mode Enhancements
        { mode = "v", lhs = "<", rhs = "<gv", desc = "Indent left" },
        { mode = "v", lhs = ">", rhs = ">gv", desc = "Indent right" },
        { mode = "v", lhs = "J", rhs = ":m '>+1<CR>gv=gv", desc = "Move selection down" },
        { mode = "v", lhs = "K", rhs = ":m '<-2<CR>gv=gv", desc = "Move selection up" },

        -- Centred Jumps
        { mode = "n", lhs = "<C-d>", rhs = "<C-d>zz", desc = "Scroll ↓ (centred)" },
        { mode = "n", lhs = "<C-u>", rhs = "<C-u>zz", desc = "Scroll ↑ (centred)" },
        { mode = "n", lhs = "n", rhs = "nzzzv", desc = "Next match (centred)" },
        { mode = "n", lhs = "N", rhs = "Nzzzv", desc = "Prev match (centred)" },

        -- Cross-Module Toggles
        { mode = { "n", "t" }, lhs = "<leader>t", rhs = function() require("core.terminal").toggle() end, desc = "Toggle floating terminal" },
        { mode = "t", lhs = "<Esc>", rhs = "<C-\\><C-n>", desc = "Exit terminal mode" },
        { mode = "n", lhs = "<leader>T", rhs = function() require("core.theme").toggle() end, desc = "Toggle light/dark theme" },

        -- Black Hole Deletes
        { mode = "x", lhs = "<leader>p", rhs = [["_dP]], desc = "Paste without yank" },
        { mode = "v", lhs = "d", rhs = '"_d', desc = "Delete without yank" },
        { mode = "v", lhs = "x", rhs = '"_x', desc = "Delete char without yank" },
        { mode = "v", lhs = "X", rhs = '"_X', desc = "Delete char before without yank" },

        -- Explicit yanks
        { mode = {"n", "v"}, lhs = "<leader>d", rhs = "d", desc = "Cut (delete with yank)" },
        { mode = "n", lhs = "<leader>dd", rhs = "dd", desc = "Cut line" },
        { mode = "n", lhs = "<leader>D", rhs = "D", desc = "Cut to end of line" },
    }

    if has_v012 then
        table.insert(keymaps, { mode = "n", lhs = "<leader>R", rhs = "<cmd>restart<cr>", desc = "Restart Neovim" })
    end

    local delete_maps = {
        ["d"] = "Delete without yank", ["dd"] = "Delete line without yank", ["D"] = "Delete to end without yank",
        ["dw"] = "Delete word without yank", ["db"] = "Delete word back without yank", ["de"] = "Delete to end of word without yank",
        ["d$"] = "Delete to end of line without yank", ["d0"] = "Delete to start of line without yank", ["d^"] = "Delete to first non-blank without yank",
        ["diw"] = "Delete inner word without yank", ["diW"] = "Delete inner WORD without yank", ['di"'] = "Delete inside quotes without yank",
        ["di'"] = "Delete inside single quotes without yank", ["di("] = "Delete inside parentheses without yank", ["di)"] = "Delete inside parentheses without yank",
        ["dib"] = "Delete inside block without yank", ["di["] = "Delete inside brackets without yank", ["di]"] = "Delete inside brackets without yank",
        ["di{"] = "Delete inside braces without yank", ["di}"] = "Delete inside braces without yank", ["diB"] = "Delete inside Block without yank",
        ["di<"] = "Delete inside angle brackets without yank", ["di>"] = "Delete inside angle brackets without yank", ["dit"] = "Delete inside tag without yank",
        ["dip"] = "Delete inside paragraph without yank", ["daw"] = "Delete around word without yank", ["daW"] = "Delete around WORD without yank",
        ['da"'] = "Delete around quotes without yank", ["da'"] = "Delete around single quotes without yank", ["da("] = "Delete around parentheses without yank",
        ["da)"] = "Delete around parentheses without yank", ["dab"] = "Delete around block without yank", ["da["] = "Delete around brackets without yank",
        ["da]"] = "Delete around brackets without yank", ["da{"] = "Delete around braces without yank", ["da}"] = "Delete around braces without yank",
        ["daB"] = "Delete around Block without yank", ["da<"] = "Delete around angle brackets without yank", ["da>"] = "Delete around angle brackets without yank",
        ["dat"] = "Delete around tag without yank", ["dap"] = "Delete around paragraph without yank",
    }

    for key, description in pairs(delete_maps) do
        table.insert(keymaps, { mode = "n", lhs = key, rhs = '"_' .. key, desc = description })
    end

    -- Register all keymaps
    for _, map in ipairs(keymaps) do
        vim.keymap.set(map.mode, map.lhs, map.rhs, { desc = map.desc, silent = true })
    end
end

return M
