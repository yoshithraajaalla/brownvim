local M = {}

local function open_dashboard()
    if vim.fn.argc() > 0 then return end

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
end

function M.setup()
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
end

return M
