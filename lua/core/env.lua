local M = {}

local _is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
local _has_pwsh = vim.fn.executable("pwsh") == 1
local _has_powershell = vim.fn.executable("powershell.exe") == 1

function M.is_windows()
    return _is_windows
end

function M.get_shell()
    if not M.is_windows() then
        return vim.o.shell
    end
    if _has_pwsh then return "pwsh.exe" end
    if _has_powershell then return "powershell.exe" end
    return "cmd.exe"
end

function M.apply_os_quirks()
    if M.is_windows() then
        vim.fn.setenv("SHELL", M.get_shell())
        vim.fn.setenv("TERM", "")
        -- Disable git operations that might invoke WSL
        vim.fn.setenv("GIT_TERMINAL_PROMPT", "0")
    end
end

return M
