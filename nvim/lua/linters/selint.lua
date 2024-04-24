-- SELint: https://github.com/SELinuxProject/selint

-- [filename]:  [lineno]: ([SEVERITY LEVEL]): [MESSAGE] ([ISSUE ID])
local pattern = "(%S+):%s*(%d+): %((%w)%): (.+)"
local groups = { "file", "lnum", "severity", "message" }
local severities = {
    X = vim.diagnostic.severity.HINT,
    C = vim.diagnostic.severity.INFO,
    S = vim.diagnostic.severity.WARN,
    W = vim.diagnostic.severity.WARN,
    E = vim.diagnostic.severity.ERROR,
    F = vim.diagnostic.severity.ERROR,
}

return {
    cmd = "selint",
    stdin = false,
    stream = "stdout",
    -- Set working directory to the parent directory of the file to be linted
    cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
    args = {
        "--disable=E-003", -- Nonexistent user listed in fc file
        "--disable=E-004", -- Nonexistent role listed in fc file
        "--disable=E-005", -- Nonexistent type listed in fc file
    },
    ignore_exitcode = true,
    parser = require("lint.parser").from_pattern(pattern, groups, severities, {
        ["source"] = "selint",
    }),
}
