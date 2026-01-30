--   ____    ____  ________
--  |_   \  /   _||_   __  |
--    |   \/   |    | |_ \_|    Miguel Fernandes
--    | |\  /| |    |  _|       https://github.com/mdmfernandes
--   _| |_\/_| |_  _| |_
--  |_____||_____||_____|

-- Load core configurations
require("core.options")
require("core.mappings")
require("core.commands")
require("core.diagnostic")
require("core.filetype")
require("core.autocmd")

-- Load LSP
require("lsp")

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
                -- https://github.com/vim/vim/blob/master/runtime/plugin/README.txt
                -- "gzip",       -- edit gzip files
                -- "tarPlugin",  -- browse tar files
                "zipPlugin", -- edit zip files
                "vimballPlugin", -- create and unpack vba files
                "matchit", --
                "netrwPlugin", -- navigate in directories
                "tohtml", -- convert syntax highlighted file to html
                "tutor", --
                "rrhelper", -- used for --remote-wait editing
            },
        },
    },
    rocks = {
        enabled = false,
    },
})

-- netrw configuration (useful when netrwPlugin is enabled)
-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
