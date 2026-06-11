local M = {}

local function open_dashboard()
    if vim.fn.argc() > 0 then return end

    local buf = vim.api.nvim_create_buf(false, true)
    
    local width = vim.o.columns
    local height = vim.o.lines - vim.o.cmdheight
    
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        col = 0,
        row = 0,
        style = "minimal",
        zindex = 10,
    })

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

    local ns = vim.api.nvim_create_namespace("dashboard_hl")
    local h  = pad

    for i = h + 1, h + 6 do vim.api.nvim_buf_set_extmark(buf, ns, i, 0, { line_hl_group = "NeonYellow" }) end
    vim.api.nvim_buf_set_extmark(buf, ns, h + 8, 0, { line_hl_group = "NeonCyan" })

    local btn_start = h + #header
    for i = btn_start, btn_start + #buttons - 1 do
        vim.api.nvim_buf_set_extmark(buf, ns, i, 0, { line_hl_group = "NeonGreen" })
    end

    local function close_and_run(cmd)
        return function()
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
            vim.cmd(cmd)
        end
    end

    local dk = function(key, action) vim.keymap.set("n", key, action, { buffer = buf, nowait = true, silent = true }) end
    dk("f", close_and_run("Telescope find_files"))
    dk("g", close_and_run("Telescope live_grep"))
    dk("r", close_and_run("Telescope oldfiles"))
    dk("b", close_and_run("Telescope buffers"))
    dk("n", close_and_run("enew"))
    dk("q", "<cmd>qa<cr>")
    dk("?", close_and_run("Telescope keymaps"))

    -- Auto-close the floating window if we navigate away
    vim.api.nvim_create_autocmd("BufLeave", {
        buffer = buf,
        callback = function()
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end
        end,
        once = true,
    })
end

function M.setup()
    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function() vim.schedule(open_dashboard) end,
        once = true,
    })
end

return M
