local M = {}

function M.setup()
    local map = vim.keymap.set
    local has_v012 = vim.fn.has("nvim-0.12") == 1

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
    if has_v012 then
        map("n", "<leader>R", "<cmd>restart<cr>", { desc = "Restart Neovim" })
    end
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
end

return M
