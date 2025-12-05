-- GitHub Copilot: https://github.com/github/copilot.vim

-- I don't always use Copilot, so only enable it if the NVIM_COPILOT environment
-- variable is set to "true".
local function copilot_enabled()
    return vim.env.NVIM_COPILOT == "true"
end

return {
    {
        "github/copilot.vim",
        cmd = "Copilot",
        enabled = copilot_enabled,
        event = "BufWinEnter",
        init = function()
            vim.g.copilot_no_maps = true
        end,
        config = function()
            -- Block the normal Copilot suggestions
            vim.api.nvim_create_augroup("github_copilot", { clear = true })
            vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
                group = "github_copilot",
                callback = function(args)
                    vim.fn["copilot#On" .. args.event]()
                end,
            })
            vim.fn["copilot#OnFileType"]()
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        enabled = copilot_enabled,
        dependencies = {
            { "github/copilot.vim", "nvim-lua/plenary.nvim" },
        },
        build = "make tiktoken",
        opts = {
            debug = false,
            headers = {
                user = " User",
                assistant = " Copilot",
                tool = " Tool",
            },
        },
        keys = {
            { "<Leader>cc", "<Cmd>CopilotChatToggle<CR>",   desc = "Copilot Chat - Toggle",         mode = { "n", "v" } },
            { "<Leader>cd", "<Cmd>CopilotChatDocs<CR>",     desc = "Copilot Chat - Generate docs",  mode = { "n", "v" } },
            { "<Leader>ce", "<Cmd>CopilotChatExplain<CR>",  desc = "Copilot Chat - Explain",        mode = { "n", "v" } },
            { "<Leader>cf", "<Cmd>CopilotChatFix<CR>",      desc = "Copilot Chat - Fix",            mode = { "n", "v" } },
            { "<Leader>cg", "<Cmd>CopilotChatCommit<CR>",   desc = "Copilot Chat - Commit",         mode = { "n", "v" } },
            { "<Leader>co", "<Cmd>CopilotChatOptimize<CR>", desc = "Copilot Chat - Optimize",       mode = { "n", "v" } },
            { "<Leader>cr", "<Cmd>CopilotChatReview<CR>",   desc = "Copilot Chat - Review",         mode = { "n", "v" } },
            { "<Leader>ct", "<Cmd>CopilotChatTests<CR>",    desc = "Copilot Chat - Generate tests", mode = { "n", "v" } },
        },
        config = function(_, opt)
            local chat = require("CopilotChat")
            chat.setup(opt)

            -- Auto-command to customize chat buffer behavior
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-*",
                group = "github_copilot",
                callback = function()
                    vim.opt_local.relativenumber = false
                    vim.opt_local.number = false
                    vim.opt_local.conceallevel = 0
                end,
            })
        end,
    },
}
