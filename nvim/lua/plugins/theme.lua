-- Theme - OneDark: https://github.com/navarasu/onedark.nvim
return {
    "navarasu/onedark.nvim",
    priority = 1000, -- load the theme before all the other start plugins
    dependencies = { "kyazdani42/nvim-web-devicons", lazy = true },
    opts = {
        style = "cool",
        toggle_style_key = nil,
    },
    init = function()
        require("onedark").load()
    end,
    keys = {
        {
            "<Leader>tt",
            function()
                require("onedark").toggle()
                vim.notify(string.format("Switched OneDark theme to '%s'", vim.g.onedark_config.style),
                    vim.log.levels.INFO)
            end,
            desc = "Toggle theme style"
        }
    },
}
