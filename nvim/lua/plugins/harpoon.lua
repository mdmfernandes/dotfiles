-- harpoon: https://github.com/ThePrimeagen/harpoon
return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "jasonpanosso/harpoon-tabline.nvim" },
    opts = {
        settings = {
            save_on_toggle = true
        }
    },
    config = function(_, opt)
        local harpoon = require("harpoon")

        harpoon.setup(opt)
        require("harpoon-tabline").setup({ use_editor_color_scheme = false })

        -- Create mappings
        local map = require("utils").map

        map("n", "<Leader>H", function()
            harpoon:list():add()
            vim.notify(string.format("File marked as '%s'", harpoon:list():length()),
                vim.log.levels.INFO)
        end, { desc = "Harpoon mark current file" })
        map("n", "<Leader>h", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon toggle quick menu" })
        map("", "<C-h>", function()
            harpoon:list():prev()
        end, { desc = "Harpoon goto pevious marker" })
        map("", "<C-l>", function()
            harpoon:list():next()
        end, { desc = "Harpoon goto next marker" })

        -- Navigate windows
        for i = 1, 9 do
            map("n",
                string.format("<Leader>%s", i),
                function()
                    harpoon:list():select(i)
                end, { desc = string.format("Harpoon navigate to marker %d", i) }
            )
        end

        -- Custom colors
        vim.api.nvim_set_hl(0, "HarpoonActive", { foreground = "white", background = "NONE" })
        vim.api.nvim_set_hl(0, "HarpoonInactive", { foreground = "#63698c", background = "NONE" })
        vim.api.nvim_set_hl(0, "HarpoonNumberActive", { foreground = "#7aa2f7", background = "NONE" })
        vim.api.nvim_set_hl(0, "HarpoonNumberInactive", { foreground = "#7aa2f7", background = "NONE" })
        vim.api.nvim_set_hl(0, "TabLineFill", { foreground = "white", background = "NONE" })
    end,

}
