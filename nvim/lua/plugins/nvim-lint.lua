-- nvim-lint: https://github.com/mfussenegger/nvim-lint
return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre" },
    config = function()
        local lint = require("lint")

        -- Linters
        lint.linters_by_ft = {
            ansible = { "ansible_lint" },
            bitbake = { "oelint-adv" },
            dockerfile = { "hadolint" },
            markdown = { "markdownlint" },
            -- sh = { "shellcheck" }, -- bashls (LSP) uses shellcheck for linting
            yaml = { "yamllint" },
            selinux = { "selint" },
        }

        ---------------------
        -- Linters options --
        ---------------------
        -- markdownlint
        lint.linters.markdownlint.args = {
            "--disable",
            "MD013", -- disable line length limit
            "MD024", -- allow multiple headings with the same comment
            "MD033", -- allow inline HTML
            "MD041", -- allow non-headers on the first line, e.g. meta section
            "--"
        }

        -- oelint-adv
        require("lint.linters.oelint-adv").cmd = "oelint.sh"

        --------------------
        -- Custom linters --
        --------------------
        -- SELint
        lint.linters.selint = require("linters.selint")

        -- Try to lint after reading the file into the buffer, after writing the file,
        -- when leaving insert mode.
        local lint_au = vim.api.nvim_create_augroup("LintGroup", { clear = true })
        vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost", "InsertLeave" }, {
            group = lint_au,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
