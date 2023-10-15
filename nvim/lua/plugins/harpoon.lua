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

        map("n", "<Leader>hm", function()
            mark.add_file()
            vim.notify(string.format("File marked as '%s'", mark.get_current_index()),
                vim.log.levels.INFO)
        end)
        map("n", "<Leader>hr", function()
            vim.notify(string.format("Removed mark from '%s'", mark.get_current_index()),
                vim.log.levels.INFO)
            mark.rm_file()
        end)
        map("n", "<Leader>hh", ui.toggle_quick_menu)
        map("", "<C-h>", ui.nav_prev)
        map("", "<C-l>", ui.nav_next)

        -- Navigate windows
        for i = 1, 9 do
            map("n",
                string.format("<Leader>%s", i),
                function()
                    ui.nav_file(i)
                end
            )
        end
    end,
}
