-- Neogen: https://github.com/danymat/neogen
return {
    "danymat/neogen",
    version = "*", -- Only follow stable versions
    opts = {
        snippet_engine = "nvim",
        languages = {
            python = {
                template = {
                    annotation_convention = "google_docstrings",
                },
            },
        },
    },
    keys = {
        {
            "<Leader>af",
            function()
                require("neogen").generate({})
            end,
            desc = "Annotate current function",
        },
        {
            "<Leader>ac",
            function()
                require("neogen").generate({ type = "class" })
            end,
            desc = "Annotate current class",
        },
        {
            "<Leader>ad",
            function()
                require("neogen").generate({ type = "file" })
            end,
            desc = "Annotate current file",
        },
    },
}
