-- nvim-lint: https://github.com/mfussenegger/nvim-lint
return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre" },
    config = function()
        local lint = require("lint")

        -- Linters
        lint.linters_by_ft = {
            ansible = { "ansible_lint" },
            c = { "clangtidy" },
            cpp = { "clangtidy" },
            dockerfile = { "hadolint" },
            markdown = { "markdownlint" },
            sh = { "shellcheck" },
            yaml = { "yamllint" },
            selinux = { "selint" },
        }

        -- Linters options
        lint.linters.markdownlint.args = {
            "--disable",
            "MD013", -- disable line length limit
            "MD024", -- allow multiple headings with the same comment
            "MD033", -- allow inline HTML
            "MD041", -- allow non-headers on the first line, e.g. meta section
            "--"
        }

        -- Custom linters
        -- SELint
        lint.linters.selint = require("linters.selint")

        -- Try to lint after reading the file into the buffer, after writing the file,
        -- when leaving insert mode, when text is changed in Normal mode.
        local lint_au = vim.api.nvim_create_augroup("LintGroup", { clear = true })
        vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost", "InsertLeave", "TextChanged" }, {
            group = lint_au,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
