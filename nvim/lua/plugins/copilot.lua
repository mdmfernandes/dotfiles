-- GitHub Copilot: https://github.com/github/copilot.vim

-- I don't always use Copilot, so only enable it if the NVIM_COPILOT environment
-- variable is set to "true".
local function copilot_enabled()
    return vim.env.NVIM_COPILOT == "true"
end

return {
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
}
