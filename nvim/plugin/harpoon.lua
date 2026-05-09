-- harpoon: https://github.com/ThePrimeagen/harpoon
vim.pack.add({
    { src = "https://github.com/theprimeagen/harpoon", version = "harpoon2", name = "harpoon" },
    { src = "https://github.com/nvim-lua/plenary.nvim" } })

local harpoon = require("harpoon")

-- Config
harpoon.setup({
    settings = {
        save_on_toggle = true,
    },
})

-- Key Mappings
vim.keymap.set("n", "<Leader>H", function()
    harpoon:list():add()
    vim.notify(string.format("File marked as '%s'", harpoon:list():length()), vim.log.levels.INFO)
end, { desc = "Harpoon mark current file" })
vim.keymap.set("n", "<Leader>h", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon toggle quick menu" })
vim.keymap.set("", "<C-h>", function()
    harpoon:list():prev()
end, { desc = "Harpoon goto pevious marker" })
vim.keymap.set("", "<C-l>", function()
    harpoon:list():next()
end, { desc = "Harpoon goto next marker" })

-- Navigate windows
for i = 1, 9 do
    vim.keymap.set("n", string.format("<Leader>%s", i), function()
        harpoon:list():select(i)
    end, { desc = string.format("Harpoon navigate to marker %d", i) })
end
