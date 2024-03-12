-- GitHub Copilot: https://github.com/github/copilot.vim

-- I don't always use Copilot, so only enable it if the NVIM_COPILOT environment
-- variable is set to "true".
local function copilot_enabled()
    return vim.env.NVIM_COPILOT == "true"
end

return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    enabled = copilot_enabled,
    dependencies = {
        { "zbirenbaum/copilot-cmp", config = true } -- Completion
    },
    config = function()
        require("copilot").setup({
            -- Disable copilot.lua's suggestion and panel modules, as they can
            -- interfere with completions properly appearing in copilot-cmp.
            suggestion = { enabled = false },
            panel = { enabled = false },
        })
    end
}
