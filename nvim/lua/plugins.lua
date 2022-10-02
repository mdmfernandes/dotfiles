-- Plugins
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- If packer is not installed, do it
if fn.empty(fn.glob(install_path)) > 0 then
    print("Cloning and installing packer...")
    fn.system({
        "git",
        "clone",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })

    vim.cmd("packadd packer.nvim")
    print("Done!")
end

-- Only move on if we can find packer
local ok, packer = pcall(require, "packer")
if not ok then
    error("Can't find packer")
    return
end

local packer_au = vim.api.nvim_create_augroup("PackerUserConfig", { clear = true })

-- Reload packer when this file is saved
vim.api.nvim_create_autocmd("BufWritePost", {
    group = packer_au,
    pattern = "plugins.lua",
    callback = function()
        vim.cmd("source <afile> | PackerCompile")
    end,
})

local config = function(name)
    return string.format("require('%s')", name)
end

return packer.startup({
    function(use)
        -- Plugins manager
        use("wbthomason/packer.nvim")

        -- Required libs
        use("nvim-lua/plenary.nvim")

        -- Notifications
        use({
            "rcarriga/nvim-notify",
            config = config("plugins.notify"),
        })

        ---------------------------------------
        -- Treesitter: Higlighting and stuff --
        ---------------------------------------
        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = config("plugins.treesitter"),
        })

        use({
            "nvim-treesitter/nvim-treesitter-textobjects",
            after = "nvim-treesitter",
        })

        -- Annotations generator
        use({
            "danymat/neogen",
            tag = "*", -- Only follow stable versions
            after = "nvim-treesitter",
            config = config("plugins.neogen"),
        })

        ---------------------------
        -- Navigation and Search --
        ---------------------------
        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
                "nvim-telescope/telescope-file-browser.nvim",
            },
            config = config("plugins.telescope"),
        })

        -- File explorer
        -- use({
        --     "kyazdani42/nvim-tree.lua",
        --     event = "CursorHold",
        --     config = config("plugins.tree"),
        -- })
        --
        ---------------------------
        -- LSP, Snippets, Navbar --
        ---------------------------
        use({
            "neovim/nvim-lspconfig",
            requires = "hrsh7th/cmp-nvim-lsp",
            config = config("lsp"),
        })

        use({
            "jose-elias-alvarez/null-ls.nvim",
            event = "BufRead",
            config = config("lsp.null-ls"),
        })

        -- Snippets
        use({
            "L3MON4D3/LuaSnip",
        })

        -- Navbar
        use({
            "SmiteshP/nvim-navic",
            requires = "neovim/nvim-lspconfig",
        })

        -- Status
        use({
            "j-hui/fidget.nvim",
            config = function()
                require("fidget").setup()
            end
        })

        ----------------
        -- Completion --
        ----------------
        use({
            "hrsh7th/nvim-cmp",
            event = "CursorHold",
            config = config("plugins.nvim-cmp"),
            requires = "L3MON4D3/LuaSnip",
        })

        use({
            { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
            { "hrsh7th/cmp-path", after = "nvim-cmp" },
            { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
            { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
        })

        use({
            "windwp/nvim-autopairs",
            event = "InsertCharPre",
            after = "nvim-cmp",
            config = config("plugins.autopairs"),
        })

        ---------
        -- Git --
        ---------
        -- Signs
        use({
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = config("plugins.gitsigns"),
        })

        -- Diff view
        use({
            "sindrets/diffview.nvim",
            event = "BufRead",
            config = config("plugins.diffview"),
        })

        -- Status
        -- use({
        --     "TimUntersberger/neogit",
        --     event = "BufEnter",
        --     config = config("plugins.neogit"),
        -- })

        -----------------------------
        -- Themes, colors and bars --
        -----------------------------
        use({
            "navarasu/onedark.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            config = config("plugins.theme"),
        })

        -- Buffer line
        use({
            "akinsho/bufferline.nvim",
            tag = "v2.*",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            after = "onedark.nvim",
            event = "BufEnter",
            config = config("plugins.bufferline"),
        })

        -- Status line
        use({
            "nvim-lualine/lualine.nvim",
            requires = { "kyazdani42/nvim-web-devicons", opt = true },
            after = "onedark.nvim",
            event = "BufEnter",
            config = config("plugins.lualine"),
        })

        -- Icons
        use({
            "kyazdani42/nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup()
            end,
        })

        ------------
        -- Others --
        ------------
        -- Todo comments
        use({
            "folke/todo-comments.nvim",
            event = "BufRead",
            config = function()
                require("todo-comments").setup()
            end,
        })

        -- Code comments
        use({
            "numToStr/Comment.nvim",
            event = "BufRead",
            config = config("plugins.comment"),
        })

        -- Highlight code search with find (f/F) and 'till (t/T)
        use({
            "jinh0/eyeliner.nvim",
            config = config("plugins.eyeliner"),
        })

        -- Higlighting for log files
        -- TODO: Check if there's log highlighting in treesitter or other NeoVIM compatible plugin
        -- use("mtdl9/vim-log-highlighting")
    end,
    config = {
        display = {
            open_fn = function()
                return require("packer.util").float({ border = "rounded" })
            end,
        },
    },
})
