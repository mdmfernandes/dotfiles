-- harpoon: https://github.com/ThePrimeagen/harpoon
return {
    "ThePrimeagen/harpoon",
    config = function()
        vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
        vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
        vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
        vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
        vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")

        require("harpoon").setup({
            tabline = true,
        })

        -- Create mappings
        local map = require("utils").map

        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        map("n", "<Leader>H", function()
            mark.add_file()
            vim.notify(string.format("File marked as '%s'", mark.get_current_index()),
                vim.log.levels.INFO)
        end, { desc = "Harpoon mark current file" })
        map("n", "<Leader>h", ui.toggle_quick_menu, { desc = "Harpoon toggle quick menu" })
        map("", "<S-h>", ui.nav_prev, { desc = "Harpoon goto next marker" })
        map("", "<S-l>", ui.nav_next, { desc = "Harpoon goto previous marker" })

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
