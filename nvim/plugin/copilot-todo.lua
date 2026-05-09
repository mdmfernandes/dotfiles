-- GitHub Copilot: https://github.com/github/copilot.vim

-- I don't always use Copilot, so only enable it if the NVIM_COPILOT environment
-- variable is set to "true".
local function copilot_enabled()
    return vim.env.NVIM_COPILOT == "true"
end

if copilot_enabled() then
    vim.pack.add({
        { src = "https://github.com/zbirenbaum/copilot.lua", name = "copilot" },
    })

    require("copilot").setup()
end
