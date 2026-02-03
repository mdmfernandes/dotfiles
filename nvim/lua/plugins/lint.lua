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
            python = { "mypy" },
            -- sh = { "shellcheck" }, -- bashls (LSP) uses shellcheck for linting
            yaml = { "yamllint" },
            selinux = { "selint" },
        }

        ---------------------
        -- Linters options --
        ---------------------
        local conf_lang_dir = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config") .. "/lang/"

        -- markdownlint - the name of the config needs to be .markdownlint.yaml or .markdownlint.json
        lint.linters["markdownlint-cli2"].args = {
            "--config", conf_lang_dir .. ".markdownlint.yaml",
            "--"
        }

        -- yamllint
        lint.linters.yamllint.args = {
            "--config-file", conf_lang_dir .. "yamllint.yaml",
            "--format", "parsable",
            "-"
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
