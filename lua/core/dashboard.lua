local M = {}

local function open_dashboard()
    if vim.fn.argc() > 0 then return end

    -- Capture original window options
    local original_num = vim.wo.number
    local original_relnum = vim.wo.relativenumber
    local original_signcol = vim.wo.signcolumn
    local original_cursorline = vim.wo.cursorline
    local original_foldcol = vim.wo.foldcolumn

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_current_buf(buf)

    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].buflisted = false
    vim.bo[buf].swapfile = false
    vim.bo[buf].modifiable = true

    local v = vim.version()
    local v_string = string.format("v%d.%d.%d", v.major, v.minor, v.patch)

    local header = {
        "",
        "  ██████╗ ██████╗  ██████╗ ██╗    ██╗███╗   ██╗██╗   ██╗██╗███╗   ███╗ ",
        "  ██╔══██╗██╔══██╗██╔═══██╗██║    ██║████╗  ██║██║   ██║██║████╗ ████║ ",
        "  ██████╔╝██████╔╝██║   ██║██║ █╗ ██║██╔██╗ ██║██║   ██║██║██╔████╔██║ ",
        "  ██╔══██╗██╔══██╗██║   ██║██║███╗██║██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██████╔╝██║  ██║╚██████╔╝╚███╔███╔╝██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "",
        "  Minimal. Intentional. Fast.               Neovim " .. v_string,
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

    -- Restore options when leaving the dashboard buffer
    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = buf,
        callback = function()
            vim.wo.number = original_num
            vim.wo.relativenumber = original_relnum
            vim.wo.signcolumn = original_signcol
            vim.wo.cursorline = original_cursorline
            vim.wo.foldcolumn = original_foldcol
        end,
        once = true,
    })
end

function M.setup()
    vim.opt.shortmess:append("I")

    vim.api.nvim_create_autocmd("VimEnter", {
        callback = open_dashboard,
        once = true,
    })
end

return M
