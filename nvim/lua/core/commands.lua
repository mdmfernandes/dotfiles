-- User commands

-- Format current buffer with the provided formatter
local formatter = require("formatter")

vim.api.nvim_buf_create_user_command(0, "Format",
    function(opts)
        formatter.setup(opts.fargs)
    end, {
        nargs = "*",
        complete = function(ArgLead, CmdLine, CursorPos)
            return formatter.complete(ArgLead, CmdLine, CursorPos)
        end,
    })
