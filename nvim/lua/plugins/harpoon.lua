-- harpoon: https://github.com/ThePrimeagen/harpoon
return {
    "ThePrimeagen/harpoon",
    config = function()
        local harpoon = require "harpoon"
        harpoon.setup()

        -- Create mappings
        local map = require("utils").map

        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        map("n", "<Leader>ha", function()
            mark.add_file()
            vim.notify(string.format("File marked as '%s'", mark.get_current_index()),
                vim.log.levels.INFO)
        end, { desc = "Harpoon mark current file" })
        map("n", "<Leader>hd", function()
            vim.notify(string.format("Removed mark from '%s'", mark.get_current_index()),
                vim.log.levels.INFO)
            mark.rm_file()
        end, { desc = "Harpoon remove mark from current file" })
        map("n", "<Leader>hh", ui.toggle_quick_menu, { desc = "Harpoon toggle quick menu" })
        map("", "<C-h>", ui.nav_prev, { desc = "Harpoon goto next marker" })
        map("", "<C-l>", ui.nav_next, { desc = "Harpoon goto previous marker" })

        -- Navigate windows
        for i = 1, 9 do
            map("n",
                string.format("<Leader>%s", i),
                function()
                    ui.nav_file(i)
                end, { desc = string.format("Harpoon navigate to marker %d", i) }
            )
        end
    end,
}
