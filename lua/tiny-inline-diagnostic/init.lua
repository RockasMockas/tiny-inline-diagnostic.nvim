local M = {}
local hi = require("tiny-inline-diagnostic.highlights")
local diag = require("tiny-inline-diagnostic.diagnostic")

local default_config = {
    signs = {
        left = "",
        right = "",
        diag = "●",
        arrow = "    ",
        vertical = " │",
        vertical_end = " └"
    },
    hi = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint",
        arrow = "NonText",
        background = "None",
    },
    blend = {
        factor = 0.27,
    },
    options = {
        clear_on_insert = false,
        overflow = "wrap",
        break_line = {
            enabled = true,
            after = 10,
        }
    }
}

function M.setup(opts)
    if opts == nil then
        opts = {}
    end

    local config = vim.tbl_deep_extend("force", default_config, opts)

    hi.setup_highlights(config.blend, config.hi)
    diag.set_diagnostic_autocmds(config)
end

function M.change(background, factor)
    local config = vim.tbl_deep_extend("force", default_config, {
        blend = {
            factor = factor,
        },
        hi = {
            background = background,
        }
    })

    hi.setup_highlights(config.blend, config.hi)
end

-- Other API
function M.get_diagnostic_under_cursor(buf)
    local diags, curline = diag.get_diagnostic_under_cursor(buf)

    if diags == nil then
        return
    end

    return diags, curline + 1
end

return M
