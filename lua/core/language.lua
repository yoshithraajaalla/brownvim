local M = {}

M._toolchains = {}

function M.setup(toolchains)
    M._toolchains = toolchains
end

function M.init_conform()
    local conform = require("conform")
    local by_ft = {}
    for lang, spec in pairs(M._toolchains) do
        if spec.formatters then
            by_ft[lang] = spec.formatters
        end
    end

    conform.formatters.isort = {
        inherit = true,
        args = { "--profile", "black", "-" },
    }

    conform.setup({
        formatters_by_ft = by_ft,
        format_on_save = {
            timeout_ms = 5000,
            lsp_fallback = true,
        },
    })
end

function M.init_mason()
    local ensure = {}
    for lang, spec in pairs(M._toolchains) do
        if type(spec.lsp) == "string" then
            table.insert(ensure, spec.lsp)
        end
        if type(spec.lsp) == "table" and spec.lsp.name then
            table.insert(ensure, spec.lsp.name)
        end
        if spec.formatters then
            for _, f in ipairs(spec.formatters) do
                table.insert(ensure, f)
            end
        end
        if spec.tools then
            for _, t in ipairs(spec.tools) do
                table.insert(ensure, t)
            end
        end
    end

    require("mason-tool-installer").setup({
        ensure_installed = ensure
    })
end

function M.init_lsp()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local enable_list = {}
    for lang, spec in pairs(M._toolchains) do
        if spec.lsp then
            local lsp_name = type(spec.lsp) == "string" and spec.lsp or spec.lsp.name
            local lsp_opts = { capabilities = capabilities }
            if type(spec.lsp) == "table" and spec.lsp.settings then
                lsp_opts.settings = spec.lsp.settings
            end

            vim.lsp.config(lsp_name, lsp_opts)
            table.insert(enable_list, lsp_name)
        end
    end

    if #enable_list > 0 then
        vim.lsp.enable(enable_list)
    end
end

return M
