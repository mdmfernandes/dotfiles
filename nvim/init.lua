--   ____    ____  ________
--  |_   \  /   _||_   __  |
--    |   \/   |    | |_ \_|    Miguel Fernandes
--    | |\  /| |    |  _|       https://github.com/mdmfernandes
--   _| |_\/_| |_  _| |_
--  |_____||_____||_____|

-- Load core configurations
require("core.options")
require("core.mappings")
require("core.diagnostic")
require("core.filetype")
require("core.autocmd")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Get lazy.nvim, if not installed
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins", {
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
