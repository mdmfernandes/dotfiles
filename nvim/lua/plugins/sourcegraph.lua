-- Sourcegraph: https://github.com/sourcegraph/sg.nvim
return {
    "sourcegraph/sg.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
        local map = require("utils").map
        map("n", "<Leader>ss", require("sg.extensions.telescope").fuzzy_search_results)
    end

}
