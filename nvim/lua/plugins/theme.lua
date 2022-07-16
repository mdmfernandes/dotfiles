-- Theme - OneDark: https://github.com/navarasu/onedark.nvim
local onedark = require("onedark")
onedark.setup({
    style = "cool",
    toggle_style_key = nil,
})
onedark.load()

-- toggle theme style
require("utils").map("n", "<Leader>tt", function()
    onedark.toggle()
    vim.notify(string.format("Switched OneDark theme to '%s'", vim.g.onedark_config.style), vim.log.levels.INFO)
end)
