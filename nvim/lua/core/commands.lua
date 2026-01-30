-- User commands

-- Format current buffer with the provided parser
local parser = require("parser")

vim.api.nvim_buf_create_user_command(0, "Parse", function(opts)
    parser.setup(opts.fargs)
end, {
    nargs = "*",
    complete = function(ArgLead, CmdLine, CursorPos)
        return parser.complete(ArgLead, CmdLine, CursorPos)
    end,
})
